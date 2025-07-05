extends Node
@export var lobby_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.player_connected.connect(_on_player_connected, ConnectFlags.CONNECT_ONE_SHOT)
	PlayerManager.start_game.connect(_on_start_game)


func _on_start_game(value):
	pass

func _on_player_connected(_node):
	get_tree().change_scene_to_packed(lobby_scene)
