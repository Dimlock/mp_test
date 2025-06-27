extends Node


@export var player_scene: PackedScene

@onready var players: Node = %Players

var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()

func _ready() -> void:
	pass


func create_server():
	peer.create_server(6666)
	multiplayer.multiplayer_peer = peer
	create_player("Server", 1)

func create_client():
	peer.create_client("localhost", 6666)
	multiplayer.multiplayer_peer = peer
	await multiplayer.connected_to_server
	print(str(multiplayer.get_unique_id()) + " connected")

@rpc("any_peer")
func create_player(player_name, player_id):
	var player_node = player_scene.instantiate()
	player_node.name = player_name
	player_node.set_multiplayer_authority(player_id)
	players.add_child(player_node)

@rpc
func spawn_players():
	for player in players.get_children():
		pass
