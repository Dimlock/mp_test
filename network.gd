extends Node

@export var chat_scene: PackedScene

var peers = []
var chat_history = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_peer_connected(id):
	if multiplayer.is_server():
		peers.append({"Name": "Player" + str(id), "id": id})
		if peers.size() == 2:
			change_scene.rpc(peers)
			
@rpc("any_peer", "call_local")
func get_message(message: String) -> void:
	chat_history += "\n" + get_nickname(multiplayer.get_remote_sender_id()) + ": " + message
	
func get_nickname(id):
	for peer in peers:
		if peer["id"] == id:
			return peer["Name"]

@rpc("call_local")
func change_scene(p):
	peers = p
	get_tree().change_scene_to_packed(chat_scene)
