extends Node

signal chat_history_changed(message)

var chat_history = "":
	set(value):
		chat_history = value
		chat_history_changed.emit(value)

func _ready() -> void:
	if multiplayer.get_unique_id() != 1:
		await multiplayer.connected_to_server
		get_chat_history.rpc_id(1)

@rpc("any_peer", "call_local")
func send_message(message):
	var player = PlayerManager.get_player_by_id(multiplayer.get_remote_sender_id())
	if not player:
		player = PlayerManager.get_player_by_id(get_multiplayer_authority())
	chat_history += "\n" + player.name + ": " + message

@rpc("any_peer")
func get_chat_history():
	send_chat_history.rpc_id(multiplayer.get_remote_sender_id(), chat_history)
	
@rpc
func send_chat_history(p_chat_history):
	chat_history = p_chat_history
