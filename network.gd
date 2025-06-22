extends Node

signal player_count_changed

@export var chat_scene: PackedScene

var peers = []
var player_count = 0:
	set(value):
		player_count = value
		player_count_changed.emit()

@rpc("call_local")
func change_scene():
	get_tree().change_scene_to_packed(chat_scene)
	
	
func find_peer_nickname(id):
	for peer in peers:
		if peer["id"] == id:
			return peer["Name"]
			
@rpc("any_peer")
func add_peer(name, id):
	peers.append({"id": id, "name": name})

@rpc("any_peer")
func increment_player_count():
	player_count += 1
