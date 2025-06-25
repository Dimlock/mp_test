class_name CustomMultiplayerAPI
extends MultiplayerAPIExtension

var base_multiplayer = SceneMultiplayer.new()
var peer_name

func _init() -> void:
	var pc = peer_connected
	base_multiplayer.peer_connected.connect(func(id): pc.emit(id, peer_name))
