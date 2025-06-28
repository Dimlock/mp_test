extends Node

signal player_connected(player_node: Node)

@export var player_scene: PackedScene
@export var lobby_scene: PackedScene

@onready var players: Node = %Players

var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
var player: Node

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)

func create_server():
	peer.create_server(6666)
	multiplayer.multiplayer_peer = peer
	create_player("Server", 1)
	get_tree().change_scene_to_packed(lobby_scene)
	

func create_client(client_name):
	peer.create_client("localhost", 6666)
	multiplayer.multiplayer_peer = peer
	create_player(client_name, multiplayer.get_unique_id())
	get_tree().change_scene_to_packed(lobby_scene)

@rpc("any_peer")
func create_player(player_name, player_id):
	var player_node = player_scene.instantiate()
	player_node.name = player_name
	player_node.set_multiplayer_authority(player_id)
	players.add_child(player_node)
	if !multiplayer.get_remote_sender_id():
		player = player_node
	else:
		player_connected.emit(player_node)
	

func _on_peer_connected(id):
	create_player.rpc_id(id, player.name, player.get_multiplayer_authority())
