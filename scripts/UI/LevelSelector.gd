extends Control

export (Array, Resource) var levels: Array
export var main_level_tile: PackedScene

var level_tiles: = []

func _ready () -> void:
	generate_tiles ()

func generate_tiles () -> void:
	var offset: = 0.0
	
	for i in levels.size ():
		var level_data: LevelData = levels [i]
		var level_tile: MainLevelTile = main_level_tile.instance ()
		level_tile.level_data = level_data
		level_tiles.append (level_tile)
		
		level_tile.rect_position = Vector2 (offset, 0)
		offset += 1920
		
		add_child (level_tile)
