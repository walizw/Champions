extends Resource
class_name LevelData

export var id: = -1
export var name: = "Stereo Madness"
export var is_local: = false
export var to_scene: = ""

export({"na": 0,
		"easy": 1,
		"normal": 2,
		"hard": 3,
		"harder": 4,
		"insane": 5,
		"demon": 6}) var difficulty: = 0

export (Resource) var reward: Resource
