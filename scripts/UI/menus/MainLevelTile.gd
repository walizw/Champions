class_name MainLevelTile
extends Control

var level_data: LevelData setget set_level_data

func set_level_data (val: LevelData) -> void:
	level_data = val
	
	$SceneButton/DifficultyFace.frame = level_data.difficulty
	$SceneButton/Name.text = level_data.name
	$SceneButton/StarsIcon/Stars.text = str (level_data.stars)
	$SceneButton.to_scene = level_data.scene_path
