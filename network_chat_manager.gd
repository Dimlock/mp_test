extends Node

signal chat_history_changed(message)


var chat_history = "":
	set(value):
		chat_history = value
		chat_history_changed.emit(value)

@rpc("any_peer")
func send_message(message):
	chat_history += "\n" + Network.find_peer_nickname(multiplayer.get_remote_sender_id()) + ": " + message
