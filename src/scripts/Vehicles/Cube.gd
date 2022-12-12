extends Vehicle

func _ready () -> void:
	spr_a.frame = PlayerData.cube
	spr_b.frame = PlayerData.cube

func _physics_process (delta: float) -> void:
	rotate_cube ()
	
	if Input.is_action_pressed ("jump") and is_on_floor ():
		jump ()
	
	velocity.y = move_and_slide (velocity, Vector2.UP if PlayerData.gravdir == 1 else Vector2.DOWN).y
	
	if trail and is_on_floor ():
		self.trail = false
	
	draw_cubes ()

func jump () -> void:
	velocity.y = -speed.y * PlayerData.gravdir

func draw_cubes () -> void:
	spr_a.flip_v = true if PlayerData.gravdir == -1 else false
	spr_b.flip_v = true if PlayerData.gravdir == -1 else false

func rotate_cube () -> void:
	if not is_on_floor ():
		angle -= 6.0
	
	if angle < -450:
		angle = -90
	
	if is_on_floor ():
		reset_rotation ()
	
	if angle <= -360:
		angle = 0
	
	spr_a.rotation_degrees = -angle
	spr_b.rotation_degrees = -angle

func reset_rotation () -> void:
	if angle > -450 and angle < -270:
		reset_angle (-360)
	elif angle > -360 and angle < -180:
		reset_angle (-270)
	elif angle > -270 and angle < -90:
		reset_angle (-180)
	elif angle > -180 and angle < 0:
		reset_angle (-90)

func reset_angle (_angle) -> void:
	if angle > _angle:
		angle -= 12
		
		if angle < _angle:
			angle = _angle
	elif angle < _angle:
		angle += 12
		
		if angle > _angle:
			angle = _angle


func _on_Hitbox_body_entered(body: Node) -> void:
	if (body is TileMap and body.collision_layer == 4) or body.collision_layer == 2:
		# this is a trap or a wall
		die ()
	elif body is TileMap and body.collision_layer == 16:
		var tmap: TileMap = body
		var world_pos: = tmap.world_to_map (tmap.to_local (global_position))
		var tile: = tmap.get_cellv (world_pos)
		
		var i: = 1
		while tile == -1:
			# We will try to look for a tile in different directions
			var dirs: = [
				Vector2 (-i,  0), # left
				Vector2 ( 0, -i), # top
				Vector2 ( i,  0), # right
				Vector2 ( 0,  i), # bottom
				Vector2 (-i,  i), # bottom-left
				Vector2 (-i, -i), # top left
				Vector2 ( i, -i), # top right,
				Vector2 ( i,  i)  # bottom right
			]
			
			for j in dirs:
				var cur_dir: Vector2 = j
				var new_pos: = world_pos + cur_dir
				var new_tile: = tmap.get_cellv (new_pos)
				
				if new_tile != -1:
					tile = new_tile
					break
			i += 1
		
		handle_special (tile, world_pos)
