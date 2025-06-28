extends Control
@onready var name_input: LineEdit = %NameInput

func _on_host_pressed() -> void:
	if check_peer_name():
		Network.create_server()

func _on_connect_pressed() -> void:
	if check_peer_name():
		Network.create_client(name_input.text)

func check_peer_name():
	return not name_input.text.is_empty()
