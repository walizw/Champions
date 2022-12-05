extends StaticBody2D

export var top: = false # if true, this ground is on top
onready var sprite: = $Sprite

func _ready () -> void:
	if top:
		sprite.flip_v = true
		global_position.y = PlayerData.g2y
	else:
		global_position.y = PlayerData.g1y

func _process (delta: float) -> void:
	sprite.modulate = PlayerData.gcolor
	
	if top and global_position.y != PlayerData.g2y:
		global_position.y = lerp (global_position.y, PlayerData.g2y, 0.5)
	elif not top and global_position.y != PlayerData.g1y:
		global_position.y = lerp (global_position.y, PlayerData.g1y, 0.5)
