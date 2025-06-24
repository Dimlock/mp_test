extends Label
@onready var timer: Timer = $Timer



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = str(roundi(timer.time_left))


func _on_timer_timeout() -> void:
	queue_free()
