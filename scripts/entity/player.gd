extends CharacterBody2D



const JUMP_VELOCITY = -175.0
const FRAMES_FOR_JUMP = 23

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var frames_for_jump: int = FRAMES_FOR_JUMP
var jumping: bool = false

const FRAMES_FOR_BOOST: int = 40
const FRAMES_FOR_STOP: int = 10
const SPEED = 125.0
var direction: int = 0

func _ready():
	print(collision_layer)
	$sprite.play()

func _process(delta):
	if jumping or not is_on_floor():
		$sprite.set_animation('jump')
	if is_on_floor() and not jumping:
		if velocity.x != 0:
			if sign(velocity.x) != direction and direction != 0:
				$sprite.set_animation('stop')
			else:
				$sprite.set_animation('move')
		else:
			$sprite.set_animation('idle')

func _physics_process(delta):
	############################################################################
	# JUMP
	############################################################################
	if not is_on_floor() and not jumping:
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jumping = true
	if Input.is_action_just_released('ui_accept'):
		jumping = false

	if jumping and frames_for_jump > 0:
		velocity.y = JUMP_VELOCITY
		frames_for_jump -= 1
	else:
		jumping = false
		frames_for_jump = FRAMES_FOR_JUMP
		
	############################################################################
	# MOVEMENT
	############################################################################
	direction = 0
	direction = Input.get_axis("ui_left", "ui_right")
	if velocity.x < 0 and scale.y > 0:
		scale.x = scale.y * -1
	if velocity.x > 0 and scale.y < 0:
		scale.x = scale.y * 1
	
	if direction:
		velocity.x = move_toward(velocity.x, SPEED * direction, SPEED / FRAMES_FOR_BOOST)
		#velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / FRAMES_FOR_STOP)

	move_and_slide()

func death():
	print('Player dead')

func kill_jump():
	velocity.y = -250
