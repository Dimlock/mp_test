extends Control
@onready var chat_text: TextEdit = %ChatText
@onready var message_text: LineEdit = %MessageText
@onready var network_chat_manager: Node = %NetworkChatManager



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	network_chat_manager.chat_history_changed.connect(_on_chat_history_changed)



func _on_send_pressed() -> void:
	if not multiplayer.is_server():
		network_chat_manager.send_message.rpc_id(1, message_text.text)
	else:
		network_chat_manager.send_message(message_text.text)

func _on_chat_history_changed(message):
	chat_text.text = message
