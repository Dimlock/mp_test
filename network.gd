extends Node

@export var player_scene: PackedScene

@onready var players: Node = %Players

var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
var player: Node

func create_server():
	peer.create_server(6666)
	multiplayer.multiplayer_peer = peer
	PlayerManager.create_player("Server", 1)
	
func create_client(client_name):
	peer.create_client("localhost", 6666)
	multiplayer.multiplayer_peer = peer
	PlayerManager.create_player(client_name, multiplayer.get_unique_id())
