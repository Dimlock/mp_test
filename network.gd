extends Node


@export var peer_scene: PackedScene

@onready var peers: Node = %Peers
@onready var peer_spawner: MultiplayerSpawner = $PeerSpawner

func _ready() -> void:
	peer_spawner.spawn_function = custom_spawn

func spawn_peer(peer_id, peer_name):
	var new_peer = peer_scene.instantiate()
	new_peer.name = peer_name
	new_peer.id = peer_id
	peers.add_child(new_peer, true)
	peer_spawner.spawn(new_peer)
	
func custom_spawn(data):
	return data
