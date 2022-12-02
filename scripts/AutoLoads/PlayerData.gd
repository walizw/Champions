extends Node

# 490
var speed: = Vector2 (615, 1200)

var cube: = 1 # the frame of the cube
var ship: = 1

var color_a: = Color.yellow
var color_b: = Color.aqua

var speed_boost: = 1 # this is used for speeds, as it multiplies the base speed

var grav: = 5600 # gravity
var gravdir: = 1 # if -1, the player will be upside down

var yscroll: = true # determines whether the camera can go up and down, i.e. false on ship
var canring: = false # if true, and collided with a ring, do its thing?

var gcolor: = Color.blue
var bgcolor: = Color.blue

var g1y: = -100000 # top ground y
var g2y: = 728

func reset_vars ():
	# Useful when changing levels
	speed_boost = 1
	gravdir = 1
	yscroll = true
	canring = false
	
	g1y = -100000
	g2y = 728

# Calculates g1y and g2y with `blocks_apart' in between them
func calc_ground_y (blocks_apart: int) -> void:
	# TODO: This
	pass

# TODO: Should all the vehicles be instantiated at _ready?
func vehicle_transform (from: Vehicle, to: String) -> void:
	var to_scene = ResourceLoader.load (to)
	var ins: Vehicle = to_scene.instance ()
	from.queue_free ()
	ins.global_position = from.global_position
	get_tree ().get_root ().add_child (ins)
