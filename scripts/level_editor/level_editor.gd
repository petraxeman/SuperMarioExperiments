extends Node2D


var player_position = null
var current_tile = 0
var tile_types = {0: Vector2(1, 0),
				  1: Vector2(0, 0),
				  100: 100,
				  101: 101}

var level_data = {}

func _process(delta):
	if Input.is_key_pressed(KEY_1):
		current_tile = 0
	if Input.is_key_pressed(KEY_2):
		current_tile = 1
	if Input.is_key_pressed(KEY_3):
		current_tile = 100
	if Input.is_key_pressed(KEY_4):
		current_tile = 101
		
	var tile_map_pos = Vector2i(get_global_mouse_position() / 16)#.snapped(Vector2(16, 16))# + Vector2(.5, .5)# / 16
	
	if Input.is_action_pressed('left_mouse'):
		print(tile_map_pos)
		if current_tile < 100:
			$level.set_cell(0, tile_map_pos, 0, tile_types[current_tile], 0)
			level_data[tile_map_pos] = ({'pos': tile_map_pos, 'type': current_tile})
			#print(tile_pos)
		if current_tile == 100:
			if tile_map_pos != player_position and player_position != null:
				$level.set_cell(0, player_position, -1)
			$level.set_cell(0, tile_map_pos, 1, Vector2(0, 0), 0)
			player_position = tile_map_pos
		if current_tile == 101:
			$level.set_cell(0, tile_map_pos, 2, Vector2(0, 0), 0)
			
	if Input.is_action_pressed('right_mouse'):
		$level.set_cell(0, tile_map_pos, -1)
