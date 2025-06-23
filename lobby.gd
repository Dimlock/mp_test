extends Control

@export var player_in_lobby_scene: PackedScene
@export var timer_scene: PackedScene

@onready var players_list: VBoxContainer = %PlayersList
@onready var multiplayer_spawner: MultiplayerSpawner = $MultiplayerSpawner
@onready var network_lobby_handler: Node = $NetworkLobbyHandler
@onready var timer_spawner: Control = $TimerSpawner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer_spawner.spawn_function = custom_spawn
	multiplayer.peer_connected.connect(_on_peer_connected)
	if multiplayer.is_server():
		_on_peer_connected(1)


func _on_peer_connected(id):
	if id != 1:
		await Network.peer_added
	var peer = Network.find_peer_by_id(id)
	multiplayer_spawner.spawn(peer)

func custom_spawn(data):
	var node = player_in_lobby_scene.instantiate()
	node.setup(data["name"], data["id"])
	node.player_ready.connect(_on_player_ready)
	node.player_not_ready.connect(_on_player_not_ready)
	return node

func _on_player_ready(uid):
	network_lobby_handler.add_peer(uid)

func _on_player_not_ready(uid):
	network_lobby_handler.delete_peer(uid)


func _on_network_lobby_handler_all_players_ready() -> void:
	clear_buttons_state.rpc()
	spawn_timer.rpc()

@rpc("any_peer", "call_local")
func spawn_timer():
	var timer_node = timer_scene.instantiate()
	timer_spawner.add_child(timer_node)

@rpc("any_peer", "call_local")
func clear_buttons_state():
	for child in players_list.get_children():
		child.clear_button_state()
