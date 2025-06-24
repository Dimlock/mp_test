extends Control

@export var player_in_lobby_scene: PackedScene
@export var timer_scene: PackedScene

@onready var players_list: VBoxContainer = %PlayersList
@onready var multiplayer_spawner: MultiplayerSpawner = $MultiplayerSpawner
@onready var network_lobby_handler: Node = $NetworkLobbyHandler
@onready var timer_spawner: Control = $TimerSpawner

func _ready() -> void:
	multiplayer_spawner.spawn_function = custom_spawn
	multiplayer.peer_connected.connect(_on_peer_connected)
	if multiplayer.is_server():
		_on_peer_connected(1)


func _on_peer_connected(id):
	if id != 1:
		await Network.peer_added
	var peer = Network.find_peer_by_id(id)
	if multiplayer.is_server():
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
	if multiplayer.is_server():
		var timer_node = timer_scene.instantiate()
		timer_spawner.add_child(timer_node)

func _on_network_lobby_handler_someone_not_ready() -> void:
	if multiplayer.is_server():
		if timer_spawner.get_child_count() > 1:
			for child in timer_spawner.get_children():
				if not child is MultiplayerSpawner:
					child.queue_free()
