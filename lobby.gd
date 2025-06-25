extends Control

@export var player_in_lobby_scene: PackedScene
@export var timer_scene: PackedScene

@onready var players_list: VBoxContainer = %PlayersList
@onready var multiplayer_spawner: MultiplayerSpawner = $MultiplayerSpawner
#@onready var network_lobby_handler: Node = $NetworkLobbyHandler
#@onready var timer_spawner: Control = $TimerSpawner

func _ready() -> void:
	multiplayer_spawner.spawn_function = custom_spawn
	Network.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	if multiplayer.is_server():
		_on_peer_connected(Network.get_peer(1))


func _on_peer_connected(peer):
	multiplayer_spawner.spawn(peer)

func _on_peer_disconnected(id):
	print("Wait for peer to reconnect")

func custom_spawn(data):
	var node = player_in_lobby_scene.instantiate()
	node.set_peer(data)
	node.player_ready.connect(_on_player_ready)
	node.player_not_ready.connect(_on_player_not_ready)
	return node

func _on_player_ready(id):
	pass
	
func _on_player_not_ready(id):
	pass
