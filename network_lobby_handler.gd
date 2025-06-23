extends Node

var peers_ready: Array[int]

func add_peer(uid):
	peers_ready.append(uid)
	if not multiplayer.is_server():
		send_peers_ready.rpc_id(1, peers_ready)

func delete_peer(uid):
	peers_ready.erase(uid)
	if not multiplayer.is_server():
		send_peers_ready.rpc_id(1, peers_ready)

@rpc("any_peer")
func send_peers_ready(peers_ready_array):
	peers_ready = peers_ready_array
