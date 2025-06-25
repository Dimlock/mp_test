extends Node

signal peer_connected

var peers = []

@onready var multiplayer_synchronizer: MultiplayerSynchronizer = %MultiplayerSynchronizer

func wait_for_sync():
	if peers.size() > 1:
		await multiplayer_synchronizer.synchronized


@rpc("any_peer")
func add_peer(peer_name, id):
	var is_new_peer = true
	check_peer(peer_name, id, is_new_peer)
	if is_new_peer:
		var new_peer = {"id": id, "name": peer_name, "ready": false}
		peers.append(new_peer)
		peer_connected.emit(new_peer)


func check_peer(peer_name, id, is_new_peer):
	for peer in peers:
		if peer_name == peer["name"]:
			is_new_peer = false
			peer["id"] = id
			peer_connected.emit(peer)
			break

func get_peer(id):
	for peer in peers:
		if peer["id"] == id:
			return peer
	return null
