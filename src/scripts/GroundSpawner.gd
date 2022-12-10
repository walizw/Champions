# TODO: Improve this
# This is a very bad ground spawner and it has a lot of stuff to do:
# Generate grounds as the player moves
# Keep track of old grounds and free them?

extends Node2D

var ground_scene: = preload ("res://prefabs/Ground.tscn")
var spawn_posx: = -64

func _ready () -> void:
	for i in 1000:
		spawn_ground ()

func spawn_ground () -> void:
	for i in 2:
		var spawn_instance:  = ground_scene.instance ()
		add_child (spawn_instance)
		spawn_instance.top = i % 2 == 0
		spawn_instance.global_position.x = spawn_posx
	
	spawn_posx += 256
