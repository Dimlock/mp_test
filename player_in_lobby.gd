extends HBoxContainer

signal player_ready(uid: int)
signal player_not_ready(uid: int)

@onready var player_name: Label = %PlayerName
@onready var ready_button: Button = $ReadyButton

var player_peer

func set_peer(peer):
	player_peer = peer

func _enter_tree() -> void:
	set_multiplayer_authority(player_peer["id"])

func _ready() -> void:
	player_name.text = player_peer["name"]

func _on_ready_button_pressed() -> void:
	if not ready_button.is_multiplayer_authority():
		return
	if player_peer["ready"]:
		ready_button.text = ""
		player_not_ready.emit(multiplayer.get_unique_id())
	else:
		ready_button.text = "X"
		player_ready.emit(multiplayer.get_unique_id())
	player_peer["ready"] = not player_peer["ready"]
