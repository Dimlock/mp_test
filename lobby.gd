extends Control

@export var player_in_lobby_scene: PackedScene
@export var timer_scene: PackedScene

var timer_node: Node

@onready var players_list: VBoxContainer = %PlayersList

func _ready() -> void:
	PlayerManager.player_connected.connect(create_player_in_lobby)
	PlayerManager.start_game.connect(_on_start_game)
	create_player_in_lobby(PlayerManager.current_player)
	
func create_player_in_lobby(player: Node):
	var player_in_lobby_node = player_in_lobby_scene.instantiate()
	player_in_lobby_node.set_multiplayer_authority(player.get_multiplayer_authority())
	players_list.add_child(player_in_lobby_node)
	player_in_lobby_node.set_player_name(player.name)

func _on_start_game(value):
	if value:
		timer_node = timer_scene.instantiate()
		add_child(timer_node)
	else:
		if timer_node:
			timer_node.queue_free()
