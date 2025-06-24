extends Node

signal player_count_changed
signal peer_added

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
			return peer["name"]
			
func find_peer_by_id(id):
	for peer in peers:
		if peer["id"] == id:
			return peer

@rpc("any_peer")
func add_peer(peer_name, id):
	var is_new_peer = true
	for peer in peers:
		if peer_name == peer["name"]:
			is_new_peer = false
			peer["id"] = id
			break
	if is_new_peer:
		peers.append({"id": id, "name": peer_name})
		peer_added.emit()


@rpc("any_peer")
func increment_player_count():
	player_count += 1
