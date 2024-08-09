extends Camera2D

@onready var player = $"../Player"

func _process(delta):
	var position = player.global_position
	if position.x > (global_position.x + 32):
		global_position.x += 64
	elif position.x < (global_position.x - 32):
		global_position.x -= 64

		## Check if the player is outside the bounds on the y-axis
	if position.y > (global_position.y + 32):
		global_position.y += 64
	elif position.y < (global_position.y - 32):
		global_position.y -= 64
