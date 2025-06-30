extends Node

signal chat_history_changed(message)

var chat_history = "":
	set(value):
		chat_history = value
		chat_history_changed.emit(value)

@rpc("any_peer", "call_local")
func send_message(message):
	var player = PlayerManager.get_player_by_id(multiplayer.get_remote_sender_id())
	if not player:
		player = PlayerManager.get_player_by_id(get_multiplayer_authority())
	chat_history += "\n" + player.name + ": " + message
