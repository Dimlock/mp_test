extends Node


@export var peer_scene: PackedScene

@onready var peers: Node = %Peers
@onready var peer_spawner: MultiplayerSpawner = $PeerSpawner


@rpc("any_peer")
func spawn_peer(peer_data):
	var new_peer = peer_scene.instantiate()
	new_peer.name = peer_data["name"]
	new_peer.id = peer_data["id"]
	peers.add_child(new_peer)
