extends Control
@export var lobby_scene: PackedScene
@export var peer_scene: PackedScene
@onready var name_input: LineEdit = %NameInput

func _on_host_pressed() -> void:
	if check_peer_name():
		var peer = ENetMultiplayerPeer.new()
		peer.create_server(5202)
		multiplayer.multiplayer_peer = peer
		Network.spawn_peer(1, "Server")

func _on_connect_pressed() -> void:
	if check_peer_name():
		var peer = ENetMultiplayerPeer.new()
		peer.create_client("localhost", 5202)
		multiplayer.multiplayer_peer = peer
		await multiplayer.connected_to_server
		Network.spawn_peer(multiplayer.get_unique_id(), name_input.text)

func check_peer_name():
	return not name_input.text.is_empty()

func create_peer_data():
	var data = {}
	data["name"] = name_input.text
	data["id"] = multiplayer.get_unique_id()
	return data
