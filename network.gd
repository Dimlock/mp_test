extends Node

@export var chat_scene: PackedScene

var peers = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)
	


func _on_peer_connected(id):
	if multiplayer.is_server():
		peers.append({"Name": "Player" + str(id), "id": id})
		if peers.size() == 2:
			change_scene.rpc()


@rpc("call_local")
func change_scene():
	get_tree().change_scene_to_packed(chat_scene)
	
	
func find_peer_nickname(id):
	for peer in peers:
		if peer["id"] == id:
			return peer["Name"]
