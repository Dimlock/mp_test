extends Control
@export var lobby_scene: PackedScene
@onready var name_input: LineEdit = %NameInput



func _on_host_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(5202)
	multiplayer.multiplayer_peer = peer
	Network.add_peer(name_input.text, 1)
	get_tree().change_scene_to_packed(lobby_scene)

func _on_connect_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("localhost", 5202)
	multiplayer.multiplayer_peer = peer
	await multiplayer.connected_to_server
	Network.add_peer.rpc_id(1, name_input.text, multiplayer.get_unique_id())
	get_tree().change_scene_to_packed(lobby_scene)
