extends Node


@export var peer_scene: PackedScene

@onready var peers: Node = %Peers


func _enter_tree() -> void:
	get_tree().set_multiplayer(CustomMultiplayerAPI.new())

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)

func _on_peer_connected(id, peer_name):
	var new_peer = peer_scene.instantiate()
	new_peer.name = peer_name
	peers.add_child(new_peer, true)

#@rpc("any_peer")
#func add_peer(peer_name, id):	
	#var is_new_peer = true
	#check_peer(peer_name, id, is_new_peer)
	#if is_new_peer:
		#var new_peer = {"id": id, "name": peer_name, "ready": false}
		#peers.append(new_peer)
		#peer_connected.emit(new_peer)


#func check_peer(peer_name, id, is_new_peer):
	#for peer in peers:
		#if peer_name == peer["name"]:
			#is_new_peer = false
			#peer["id"] = id
			#peer_connected.emit(peer)
			#break
#
#func get_peer(id):
	#for peer in peers:
		#if peer["id"] == id:
			#return peer
	#return null
