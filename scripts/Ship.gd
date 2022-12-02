extends Vehicle

onready var cube_a: = $Cube/CubeA
onready var cube_b: = $Cube/CubeB

func _ready () -> void:
	cube_a.modulate = PlayerData.color_a
	cube_b.modulate = PlayerData.color_b
	
	cube_a.frame = PlayerData.cube
	cube_b.frame = PlayerData.cube
	
	spr_a.frame = PlayerData.ship
	spr_b.frame = PlayerData.ship

func _physics_process (delta: float) -> void:
	velocity.y = move_and_slide (velocity, Vector2.UP if PlayerData.gravdir == 1 else Vector2.DOWN).y
