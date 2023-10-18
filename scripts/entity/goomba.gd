extends CharacterBody2D


const SPEED = 50.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = -1

func _ready():
	$sprite.play()
	
func _physics_process(delta):
	#for i in get_slide_collision_count():
	#	var collider = get_slide_collision(i).get_collider()
	#	if collider.is_in_group('player'):
	#		collider.kill()

	if velocity.x == 0:
		direction *= -1
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.x = SPEED * direction
	move_and_slide()


func _on_area_body_entered(body):
	if body.is_in_group('player'):
		var body_position = body.get_position()
		var self_position = get_position()
		if body_position.y < self_position.y - 8:
			body.kill_jump()
			$area.monitoring = false
			$sprite.set_animation('dead')
			$sprite.position.y += 4
			$timer.start()
		else:
			body.death()
	return


func _on_timer_timeout():
	queue_free()
