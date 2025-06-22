extends Control
@onready var message_text: LineEdit = $VBoxContainer/HBoxContainer/MessageText
@onready var chat_text: TextEdit = $VBoxContainer/ScrollContainer/ChatText


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NetworkChatManager.chat_history_changed.connect(_on_chat_history_changed)



func _on_send_pressed() -> void:
	if not multiplayer.is_server():
		NetworkChatManager.send_message.rpc_id(1, message_text.text)
	else:
		NetworkChatManager.send_message(message_text.text)

func _on_chat_history_changed(message):
	chat_text.text = message
