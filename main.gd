extends Control
@export var lobby_scene: PackedScene
@onready var name_input: LineEdit = %NameInput



func _on_host_pressed() -> void:
	if check_peer_name():
		var peer = ENetMultiplayerPeer.new()
		peer.create_server(5202)
		multiplayer.multiplayer_peer = peer
		Network._on_peer_connected(1, name_input.text)


func _on_connect_pressed() -> void:
	if check_peer_name():
		multiplayer.peer_name = name_input.text
		var peer = ENetMultiplayerPeer.new()
		peer.create_client("localhost", 5202)
		multiplayer.multiplayer_peer = peer


func check_peer_name():
	return name_input.text.is_empty()
