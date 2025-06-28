extends Control

@export var player_in_lobby_scene: PackedScene

@onready var players_list: VBoxContainer = %PlayersList

func _ready() -> void:
	Network.player_connected.connect(create_player_in_lobby)
	create_player_in_lobby(Network.player)
	
func create_player_in_lobby(player: Node):
	if player != Network.player:
		breakpoint
	var player_in_lobby_node = player_in_lobby_scene.instantiate()
	player_in_lobby_node.set_multiplayer_authority(player.get_multiplayer_authority())
	players_list.add_child(player_in_lobby_node)
	player_in_lobby_node.set_player_name(player.name)
