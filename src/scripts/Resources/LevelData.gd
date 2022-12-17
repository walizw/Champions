extends Resource
class_name LevelData

export var id: = -1
export var name: = "Stereo Madness"
export var is_local: = false
export (String, FILE, "*.tscn") var to_scene
export var energy_cost: = 2
export var is_extra: = false

export({"na": 0,
		"easy": 1,
		"normal": 2,
		"hard": 3,
		"harder": 4,
		"insane": 5,
		"demon": 6}) var difficulty: = 0

# if true, the user already completed this level
export var completed: = false

export (Array, Resource) var rewards: Array
