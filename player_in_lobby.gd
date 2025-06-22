extends HBoxContainer
@onready var player_name: Label = %PlayerName
@onready var ready_button: Button = $ReadyButton

var ready_pressed: bool
var uid:
	set(value):
		uid = value
		if ready_button:
			ready_button.set_multiplayer_authority(value)


func setup(player_name_param, id):
	player_name.text = player_name_param
	uid = id


func _on_ready_button_pressed() -> void:
	if not ready_button.is_multiplayer_authority():
		return
	if ready_pressed:
		ready_button.text = ""
	else:
		ready_button.text = "X"
	ready_pressed = not ready_pressed
	_on_ready_button_pressed_rpc.rpc_id(1, ready_button.text, ready_pressed)

@rpc("any_peer", "call_local")
func _on_ready_button_pressed_rpc(text, pressed_status):
	ready_button.text = text
	ready_pressed = pressed_status
