extends Node

var speed_boost: = 1 # this is used for speeds, as it multiplies the base speed

var gravdir: = 1 # if -1, the player will be upside down

var gcolor: = Color.blue
var bgcolor: = Color.blue

var yscroll: = true # if false, the camera won't go up
var g1y: = 5578
var g2y: = 0 # top ground y

# some preloads
var cube_vehicle: = preload ("res://prefabs/Vehicles/Cube.tscn")
var ship_vehicle: = preload ("res://prefabs/Vehicles/Ship.tscn")

func reset_vars ():
	# Useful when changing levels
	speed_boost = 1
	gravdir = 1
	
	g1y = 0
	g2y = 5578

func reset_g2y () -> void:
	g1y = 5578
	g2y = 0

# Calculates g1y and g2y
func calc_ground_y (pos: Vector2, sep: int) -> void:
	var ty: int = pos.y if pos.y < 2 else 5
	
	for i in floor (sep / 2):
		if ty < 10:
			ty += 1
	var ty2: = ty
	for i in sep:
		ty2 -= 1
	g1y = ((ty * 60) + 128) + 4850
	g2y = ((ty2 * 60) - 128) + 4850

# TODO Should all the vehicles be instantiated at _ready?
# I am not sure if this might affect the performance, should there be variables
# containing an instance of all the vehicles, so we would just need to add them as
# child to the tree?
func vehicle_transform (from: Vehicle, to: String) -> void:
	if from.name == to:
		return
	
	var ins: Vehicle
	if to == "Cube":
		ins = cube_vehicle.instance ()
	elif to == "Ship":
		ins = ship_vehicle.instance ()
	ins.global_position = from.global_position
	get_tree ().get_root ().add_child (ins)
	from.queue_free ()
