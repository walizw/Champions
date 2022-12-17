extends Node
class_name Level

onready var background: = $ParallaxBackground/ParallaxLayer/Background

onready var win_wall: = $WinWall
onready var win_wall_area: = $WinWall/Area
onready var camera: = $Camera

onready var pause_menu: = $PauseMenu

export var initial_bgcolor: = Color.blue
export var initial_gcolor: = Color.blue

export var song: String

# TODO Finish level
# Make the initial_speedbost and initial_vehicle work. There are still some fields
# that are missing such as the background and ground texture.
export var initial_speedboost: = 1
export(String, "Cube", "Ship", "Ball", "Ufo", "Wave", "Robot", "Spider") var initial_vehicle
export var initial_vehicle_pos: = Vector2 (-60, 5420)

var level_length: = 0.0 # the total length (in pixels) of the level width

func _ready () -> void:
	reset_vars ()
	spawn_vehicle ()
	
	# iterate through all the tiles, so we get the farthest tile
	var tiles: = [$SolidTiles, $TrapTiles, $SpecialTiles]
	
	for i in tiles:
		var tile: TileMap = i
		var len_rect: = tile.get_used_rect ()
		var total_len: = (len_rect.position.x + len_rect.size.x) * tile.cell_size.x
		if total_len > level_length:
			level_length = total_len
	
	win_wall.position.x = level_length + (60 * 5)
	camera.limit_right = win_wall.position.x
	
	win_wall_area.connect ("body_entered", self, "win_level")

func _process (delta: float) -> void:
	background.modulate = PlayerData.bgcolor
	win_wall.position.y = PlayerData.g1y - 540

func win_level (body: Node) -> void:
	Jukebox.stop_song ()
	
	if not GameData.playing_level:
		return
	
	if GameData.playing_level.is_local:
		if not GameData.playing_level.completed:
			GameData.data.level_world = GameData.playing_level.id + 1
			
			for i in GameData.playing_level.rewards:
				var reward: LevelReward = i
				
				if reward.type == 0:
					GameData.data.energy += reward.amount
				elif reward.type == 1:
					GameData.data.coins += reward.amount
				elif reward.type == 2:
					GameData.data.gems += reward.amount
				elif reward.type == 3:
					GameData.data.exp += reward.amount
				elif reward.type == 4:
					GameData.data.stars += reward.amount
	else:
		# TODO Win online levels
		# How will I handle wining online levels? :O
		pass
	
	GameData.playing_level.completed = true
	
	# TODO Display a win screen
	# Instead of directly going to the previous scene, show
	# some kind of display screen, or something like that
	get_tree ().change_scene (GameData.prev_scene)

func reset_vars () -> void:
	if song:
		Jukebox.playing_song = load (song)
	
	PlayerData.reset_vars ()
	PlayerData.bgcolor = initial_bgcolor
	PlayerData.gcolor = initial_gcolor

func spawn_vehicle () -> void:
	var vehicle: = PlayerData.create_vehicle (initial_vehicle)
	vehicle.global_position = initial_vehicle_pos
	vehicle.level = self
	add_child (vehicle)

func respawn () -> void:
	Jukebox.pause_song ()
	yield (get_tree ().create_timer (1), "timeout")
	reset_vars ()
	spawn_vehicle ()
