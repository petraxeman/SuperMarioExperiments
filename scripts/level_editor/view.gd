extends Camera2D

var moving: bool = false


func _process(delta):
	if Input.is_action_just_pressed("middle_button"):
		moving = true
	if Input.is_action_just_released("middle_button"):
		moving = false

func _input(event):
	if event is InputEventMouseMotion:
		if moving:
			position += -event.velocity / 32
