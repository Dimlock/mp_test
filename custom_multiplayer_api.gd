class_name CustomMultiplayerAPI
extends MultiplayerAPIExtension


var base_multiplayer = SceneMultiplayer.new()
var peer_name


func _init() -> void:
	var cts = connected_to_server
	var cf = connection_failed
	var pc = peer_connected
	var pd = peer_disconnected
	var sd = peer_disconnected
	base_multiplayer.server_disconnected.connect(func(): sd.emit())
	base_multiplayer.connected_to_server.connect(func(): cts.emit())
	base_multiplayer.connection_failed.connect(func(): cf.emit())
	base_multiplayer.peer_disconnected.connect(func(id): pd.emit(id))
	base_multiplayer.peer_connected.connect(func(id): pc.emit(id, peer_name))
	

# These can be optional, but in our case we want to extend SceneMultiplayer, so forward everything.
func _set_multiplayer_peer(p_peer: MultiplayerPeer):
	base_multiplayer.multiplayer_peer = p_peer

func _get_multiplayer_peer() -> MultiplayerPeer:
	return base_multiplayer.multiplayer_peer

func _get_unique_id() -> int:
	return base_multiplayer.get_unique_id()

func _get_peer_ids() -> PackedInt32Array:
	return base_multiplayer.get_peers()

# Log configuration add. E.g. root path (nullptr, NodePath), replication (Node, Spawner|Synchronizer), custom.
func _object_configuration_add(object, config: Variant) -> Error:
	return base_multiplayer.object_configuration_add(object, config)

# Log configuration remove. E.g. root path (nullptr, NodePath), replication (Node, Spawner|Synchronizer), custom.
func _object_configuration_remove(object, config: Variant) -> Error:
	return base_multiplayer.object_configuration_remove(object, config)

func _poll():
	return base_multiplayer.poll()

# Log RPC being made and forward it to the default multiplayer.
func _rpc(peer: int, object: Object, method: StringName, args: Array) -> Error:
	return base_multiplayer.rpc(peer, object, method, args)

func _get_remote_sender_id() -> int:
	return base_multiplayer.get_remote_sender_id()
