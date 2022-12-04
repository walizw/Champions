class_name MainLevelTile
extends Control

var level_data: LevelData setget set_level_data

func set_level_data (val: LevelData) -> void:
	level_data = val
	
	$MainLevelTile/DifficultyFace.frame = level_data.difficulty
	$Name.text = level_data.name
	$StarsIcon/Stars.text = str (level_data.stars)
