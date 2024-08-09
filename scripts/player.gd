extends CharacterBody2D

const MAX_SPEED = 50.0
const JUMP_VELOCITY = -100.0
const WALL_JUMP_VELOCITY_X = 100
const ACCEL = 300
const DECCEL = 300
const GRAVITY = 300

var is_on_wall = false
var wall_dir = 0

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	#if is_on_wall():
		#var wall_dir = sign(get_wall_normal().x)
	
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif is_on_wall:
			velocity.y = JUMP_VELOCITY
			velocity.x = -wall_dir * WALL_JUMP_VELOCITY_X

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		elif direction != 0:
			animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("walk")
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCEL * delta)
		print(velocity.x)
		#if direction is lower than 0 flip to other side
		if direction < 0:
			animated_sprite_2d.offset.x = 7
			animated_sprite_2d.flip_h = true
			
		elif direction > 0:
			animated_sprite_2d.offset.x = 0
			animated_sprite_2d.flip_h = false
			
		
	else:
		velocity.x = move_toward(velocity.x, 0, DECCEL * delta)

	move_and_slide()
	
