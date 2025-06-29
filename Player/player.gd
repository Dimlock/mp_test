extends Node

signal player_ready(value: bool)

var is_ready: bool:
	set(value):
		is_ready = value
		player_ready.emit(value)

@rpc("call_local")
func set_is_ready(value):
	is_ready = value
