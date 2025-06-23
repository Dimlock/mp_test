extends Control
@export var player_in_lobby_scene: PackedScene
@onready var players_list: VBoxContainer = %PlayersList
@onready var multiplayer_spawner: MultiplayerSpawner = $MultiplayerSpawner

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
	return node
