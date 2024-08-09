extends Area2D

@onready var timer = $Timer
@onready var player = $"../Player"

func _on_body_entered(body):
	if body == player:
		timer.start()
		get_tree().paused
	
func _on_timer_timeout():
	get_tree().reload_current_scene()
