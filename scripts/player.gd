extends CharacterBody2D

const MAX_SPEED = 50.0
const JUMP_VELOCITY = -100.0
const WALL_JUMP_VELOCITY_X = 100
const ACCEL = 300
const DECCEL = 300
const GRAVITY = 300

var jump_count = 0
var max_jump = 2

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCEL * delta)
		
		#if direction is lower than 0 flip to other side
		if direction < 0:
			animated_sprite_2d.offset.x = 7
			animated_sprite_2d.flip_h = true
			
		elif direction > 0:
			animated_sprite_2d.offset.x = 0
			animated_sprite_2d.flip_h = false
			
	else:
		velocity.x = move_toward(velocity.x, 0, DECCEL * delta)
	
	if is_on_floor():
		jump_count = 0
		
		if direction == 0:
			animated_sprite_2d.play("idle")
		elif direction != 0:
			animated_sprite_2d.play("walk")
	else: #they are jumping
		animated_sprite_2d.play("walk")
	
	# Add the gravity.
	if !is_on_wall():
		velocity.y += GRAVITY * delta
	elif is_on_wall():
		velocity.y += GRAVITY * 0.1 * delta
	
	if is_on_wall() and Input.is_action_just_pressed("jump"):
		print(velocity.x)
		if velocity.x > 0:
			velocity = Vector2(-70, JUMP_VELOCITY)
		elif velocity.x < 0:
			velocity = Vector2(70, JUMP_VELOCITY)
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and jump_count < max_jump:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	if Input.is_action_just_pressed("jump") and !is_on_floor() and jump_count < max_jump and !is_on_wall():
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	
	move_and_slide()
	
