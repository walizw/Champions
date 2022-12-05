class_name LevelData
extends Resource

export var name: = "Level Name"
export var scene_path: = ""
# TODO: Song file?
export var stars: = 1
export({na=0, easy=1, normal=2, hard=3, harder=4, insane=5, easy_demon=6, medium_demon=7, hard_demon=8, insane_demon=9, extreme_demon=10, auto=11}) var difficulty: = 0

func as_dict () -> Dictionary:
	return {
		"name": name,
		"stars": stars,
		"difficulty": difficulty
	}
