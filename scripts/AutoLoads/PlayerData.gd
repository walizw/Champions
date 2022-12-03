extends Node

var speed: = Vector2 (615, 1200)

var cube: = 1 # the frame of the cube
var ship: = 1

var color_a: = Color.yellow
var color_b: = Color.aqua

var speed_boost: = 1 # this is used for speeds, as it multiplies the base speed

var grav: = 5600 # gravity
var gravdir: = 1 # if -1, the player will be upside down

var canring: = false # if true, and collided with a ring, do its thing?

var gcolor: = Color.blue
var bgcolor: = Color.blue

var g1y: = 728
var g2y: = -100000 # top ground y

func reset_vars ():
	# Useful when changing levels
	speed_boost = 1
	gravdir = 1
	canring = false
	
	g1y = -100000
	g2y = 728

# Calculates g1y and g2y
func calc_ground_y (pos: Vector2, sep: int) -> void:
	# TODO: This
	var ty: = pos.y
	
	for i in floor (sep / 2):
		if ty < 12:
			ty += 1
	var ty2: = ty
	for i in sep:
		ty2 -= 1
	g1y = (ty * 60) + 128
	g2y = (ty2 * 60) - 128
	print (ty, ty2)

# TODO: Should all the vehicles be instantiated at _ready?
func vehicle_transform (from: Vehicle, to: String) -> void:
	var to_scene = ResourceLoader.load (to)
	var ins: Vehicle = to_scene.instance ()
	ins.global_position = from.global_position
	get_tree ().get_root ().add_child (ins)
	from.queue_free ()
