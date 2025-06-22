extends Control
@export var player_in_lobby_scene: PackedScene
@onready var players_list: VBoxContainer = %PlayersList
@onready var multiplayer_spawner: MultiplayerSpawner = $MultiplayerSpawner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if multiplayer.is_server():
		multiplayer.peer_connected.connect(_on_peer_connected)
		_on_peer_connected(1)

	#if multiplayer.is_server():
		#for peer in Network.peers:
			#var new_player = player_in_lobby_scene.instantiate()
			#players_list.add_child(new_player)
			#new_player.setup(peer["name"])
			#new_player.set_multiplayer_authority(peer["id"])
		

func _on_peer_connected(id):
	if id != 1:
		await Network.peer_added
	var peer = Network.find_peer_by_id(id)
	var new_player = player_in_lobby_scene.instantiate()
	players_list.add_child(new_player, true)
	new_player.setup(peer["name"], id)
