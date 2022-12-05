extends Camera2D

export var yscroll: = true

func _ready () -> void:
	zoom = Vector2 (0.65, 0.65)

func _process (delta: float) -> void:
	update_camera ()

func update_camera ():
	var cam_pos = global_position
	var player_pos = get_parent ().global_position
	var view_size = get_viewport ().size
	
	global_position.x = player_pos.x + (view_size.x / 4)
	
	if not yscroll:
		limit_top = PlayerData.g2y + 80
