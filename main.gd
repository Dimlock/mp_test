extends Control
@onready var name_input: LineEdit = %NameInput

func _on_host_pressed() -> void:
	if check_peer_name():
		Network.create_server()

func _on_connect_pressed() -> void:
	if check_peer_name():
		await Network.create_client()
		Network.create_player.rpc_id(1, name_input.text, multiplayer.get_unique_id())

func check_peer_name():
	return not name_input.text.is_empty()
