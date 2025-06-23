extends Node

signal all_players_ready

@onready var multiplayer_synchronizer: MultiplayerSynchronizer = $MultiplayerSynchronizer

var peers_ready: Array[int]:
	set(value):
		peers_ready = value
		await multiplayer_synchronizer.synchronized
		if peers_ready.size() == Network.peers.size():
			all_players_ready.emit()


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
