extends HBoxContainer


@onready var player_name: Label = %PlayerName
@onready var ready_button: Button = $ReadyButton

var ready_pressed: bool
var player_name_text: String
var uid: int

func _enter_tree() -> void:
	set_multiplayer_authority(uid)

func setup(player_name_param, id):
	player_name_text = player_name_param
	uid = id

func _ready() -> void:
	player_name.text = player_name_text

func _on_ready_button_pressed() -> void:
	if not ready_button.is_multiplayer_authority():
		return
	if ready_pressed:
		ready_button.text = ""
	else:
		ready_button.text = "X"
	ready_pressed = not ready_pressed
