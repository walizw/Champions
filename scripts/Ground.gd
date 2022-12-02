extends StaticBody2D

export var top: = false # if true, this ground is on top
onready var sprite: = $Sprite

func _ready () -> void:
	global_position.x = 128
	sprite.modulate = PlayerData.gcolor
	
	if top:
		sprite.flip_v = true

func _process (delta: float) -> void:
	if top and global_position.y != PlayerData.g1y:
		global_position.y = PlayerData.g1y
	elif not top and global_position.y != PlayerData.g2y:
		global_position.y = PlayerData.g2y
