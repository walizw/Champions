extends Camera2D

func _process (delta: float) -> void:
	update_camera ()

func update_camera ():
	var cam_pos = global_position
	var player_pos = get_parent ().global_position
	var view_size = get_viewport ().size
	
	global_position.x = player_pos.x + (view_size.x / 3)
	
	if PlayerData.yscroll:
		drag_margin_v_enabled = true
