extends Node

signal player_connected(player_node: Node)

@export var player_scene: PackedScene

var current_player: Node

@onready var players: Node = $Players

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)

@rpc("any_peer")
func create_player(player_name, player_id):
	var player_node = player_scene.instantiate()
	player_node.name = player_name
	player_node.set_multiplayer_authority(player_id)
	players.add_child(player_node)
	if !multiplayer.get_remote_sender_id():
		current_player = player_node
	else:
		player_connected.emit(player_node)
	
func _on_peer_connected(id):
	create_player.rpc_id(id, current_player.name, current_player.get_multiplayer_authority())

func get_player_by_id(id):
	for player in players.get_children():
		if player.get_multiplayer_authority() == id:
			return player
