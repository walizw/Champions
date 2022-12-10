extends Camera2D

func _ready () -> void:
	zoom = Vector2 (0.65, 0.65)

func _process (delta: float) -> void:
	update_camera ()

func update_camera ():
	var vehicles = get_tree ().get_nodes_in_group ("vehicle")
	
	if vehicles.size () == 0:
		return
	
	var player: Vehicle = vehicles [0]
	var player_pos: = player.global_position
	var view_size: = get_viewport ().size * zoom
	var pos: = get_camera_position ()
	var abs_pos: = pos - (view_size / 2)
	
	global_position.x = player_pos.x + (view_size.x / 4)
	
	if PlayerData.yscroll:
		# TODO: Fix vertical scroll
		if player_pos.y < abs_pos.y + (view_size.y / 3.5):
			global_position.y += (((player_pos.y - (view_size.y / 3.5)) - abs_pos.y) * 0.2)
		if player_pos.y > abs_pos.y + (view_size.y / 3) * 2:
			global_position.y += (((player_pos.y - (view_size.y / 3) * 2) - abs_pos.y) * 0.2)
	else:
		global_position.y += (PlayerData.g2y + (view_size.y / 1.75)) - pos.y
