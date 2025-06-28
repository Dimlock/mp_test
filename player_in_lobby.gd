extends HBoxContainer


@onready var ready_button: Button = $ReadyButton
@onready var player_name_label: Label = %PlayerName

var pressed: bool

func set_player_name(player_name):
	name = player_name
	player_name_label.text = player_name

func _on_ready_button_pressed() -> void:
	if is_multiplayer_authority():
		update_readiness.rpc()

@rpc("call_local")
func update_readiness():
	if !pressed:
		ready_button.text = "X"
	else:
		ready_button.text = ""
	pressed = !pressed
