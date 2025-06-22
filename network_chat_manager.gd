extends Node

signal chat_history_changed(message)

var chat_history = "":
	set(value):
		chat_history = value
		chat_history_changed.emit(value)

@rpc("any_peer")
func send_message(message):
	var nickname = Network.find_peer_nickname(multiplayer.get_remote_sender_id())
	if not nickname:
		nickname = Network.find_peer_nickname(1)
	chat_history += "\n" + nickname + ": " + message
