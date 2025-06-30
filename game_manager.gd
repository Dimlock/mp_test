extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.start_game.connect(_on_start_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_game(value):
	pass
