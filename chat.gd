extends Control
@onready var message_text: LineEdit = $VBoxContainer/HBoxContainer/MessageText
@onready var chat_text: TextEdit = $VBoxContainer/ScrollContainer/ChatText


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_send_pressed() -> void:
	Network.get_message.rpc(message_text.text)
	update_chat.rpc()

@rpc("any_peer","call_local")
func update_chat():
	chat_text.text = Network.chat_history
