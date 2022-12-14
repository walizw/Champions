extends Resource
class_name LevelData

export var id: = -1
export var name: = "Stereo Madness"
export var is_local: = false
export (String, FILE, "*.tscn") var to_scene
export var energy_cost: = 2

# from_scene is used to store the path of the scene
# we got to this level, i.e. a stage or an online scene
export var from_scene: = ""

export({"na": 0,
		"easy": 1,
		"normal": 2,
		"hard": 3,
		"harder": 4,
		"insane": 5,
		"demon": 6}) var difficulty: = 0

export (Array, Resource) var rewards: Array