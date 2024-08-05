extends CharacterBody2D

const SPEED = 20.0
const JUMP_VELOCITY = -50.0
const gravity = 300

@onready var animated_sprite_2d = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		elif direction != 0:
			animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("idle")
	
	if direction:
		velocity.x = direction * SPEED
		#if direction is lower than 0 flip to other side
		
		animated_sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
