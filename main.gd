extends Control
@onready var name_input: LineEdit = %NameInput

func _ready() -> void:
	multiplayer.connected_to_server.connect(_on_connected_to_server)

func _on_host_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(5202)
	multiplayer.multiplayer_peer = peer
	Network.add_peer(await handle_name(), 1)

func _on_connect_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client("localhost", 5202)
	multiplayer.multiplayer_peer = peer

func _on_connected_to_server():
	if not multiplayer.is_server():
		Network.add_peer.rpc_id(1, await handle_name(), multiplayer.get_unique_id())

func handle_name():
	if name_input.text:
		check_server_or_not(Network.increment_player_count, Network.player_count_changed)
		return name_input.text
	else:
		check_server_or_not(Network.increment_player_count, Network.player_count_changed)
		var default_name = "Player" + str(Network.player_count)
		return default_name

func check_server_or_not(fun: Callable, signal_to_await: Signal):
	if not multiplayer.is_server():
		fun.rpc_id(1)
		await signal_to_await
	else:
		fun.call()
