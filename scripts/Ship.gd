extends Vehicle

onready var cube:   = $Cube
onready var cube_a: = $Cube/CubeA
onready var cube_b: = $Cube/CubeB

func _ready () -> void:
	maxvsp = 800
	
	cube_a.modulate = PlayerData.color_a
	cube_b.modulate = PlayerData.color_b
	
	cube_a.frame = PlayerData.cube
	cube_b.frame = PlayerData.cube
	
	spr_a.frame = PlayerData.ship
	spr_b.frame = PlayerData.ship
	
	scale = Vector2 (0.8, 0.8)

func _physics_process (delta: float) -> void:
	rotate_ship ()
	
	if Input.is_action_pressed ("jump"):
		jump ()
	
	velocity.y = move_and_slide (velocity, Vector2.UP if PlayerData.gravdir == 1 else Vector2.DOWN).y

func rotate_ship () -> void:
	var toangle: = (velocity.y / 80) * 3
	angle += (toangle - angle) * 0.3
	
	scale.y = 0.8 * PlayerData.gravdir
	cube.scale = Vector2 (scale.x * 0.7, scale.y * 0.7)
	
	rotation_degrees = angle

func jump () -> void:
	var fspd: = 150
	velocity.y = clamp (velocity.y - fspd, -800, 0)


func _on_Hitbox_body_entered(body: Node) -> void:
	if body is TileMap and body.collision_layer == 4:
		# this is a trap
		die ()
	elif body is TileMap and body.collision_layer == 16:
		var tmap: TileMap = body
		var world_pos: = tmap.world_to_map (tmap.to_local (global_position))
		var tile: = tmap.get_cellv (world_pos)
		
		handle_special (tile, world_pos)
