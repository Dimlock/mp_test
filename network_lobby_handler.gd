extends Node

signal all_players_ready
signal someone_not_ready

@onready var multiplayer_synchronizer: MultiplayerSynchronizer = $MultiplayerSynchronizer

var peers_ready: Array[int]


func add_peer(uid):
	peers_ready.append(uid)
	if not multiplayer.is_server():
		send_peer_uid.rpc_id(1, uid)
	else:
		check_players_readiness()

func delete_peer(uid):
	peers_ready.erase(uid)
	if not multiplayer.is_server():
		remote_delete_peer.rpc_id(1, uid)
	else:
		check_players_readiness()

@rpc("any_peer")
func send_peer_uid(uid):
	peers_ready.append(uid)
	check_players_readiness()

@rpc("any_peer")
func remote_delete_peer(uid):
	peers_ready.erase(uid)
	check_players_readiness()

func check_players_readiness():
	if peers_ready.size() == Network.peers.size():
		all_players_ready.emit()
	else:
		someone_not_ready.emit()
		
