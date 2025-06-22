extends Control



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_host_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(5202)
	multiplayer.multiplayer_peer = peer
	Network.peers.append({"Name": "Server", "id": 1})

func _on_connect_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("localhost", 5202)
	multiplayer.multiplayer_peer = peer
