extends Node2D



func _process(_delta):
	var camera_position = get_parent().get_node("view").position - Vector2(200, 200)
	position = camera_position.snapped(Vector2(16, 16))

func _draw():
	for x in range(60):
		x -= 15
		for y in range(30):
			y -= 3
			var rect = Rect2(x*16, y*16, 16, 16)
			#rect.set_color(Color('gray', 0.5))
			draw_rect(rect, Color('gray', 0.2), false)
