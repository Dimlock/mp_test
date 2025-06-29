extends HBoxContainer


@onready var ready_button: Button = $ReadyButton
@onready var player_name_label: Label = %PlayerName

func _ready() -> void:
	PlayerManager.get_player_by_id(get_multiplayer_authority()).player_ready.connect(_on_player_ready)

func set_player_name(player_name):
	name = player_name
	player_name_label.text = player_name

func _on_ready_button_pressed() -> void:
	if is_multiplayer_authority():
		PlayerManager.current_player.set_is_ready.rpc(!PlayerManager.current_player.is_ready)

func _on_player_ready(value):
	#if is_multiplayer_authority():
		if value:
			ready_button.text = "X"
		else:
			ready_button.text = ""
