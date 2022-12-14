extends Node

onready var background: = $ParallaxBackground/ParallaxLayer/Background

onready var win_wall: = $WinWall
onready var win_wall_area: = $WinWall/Area
onready var camera: = $Camera

export var initial_bgcolor: = Color.blue
export var initial_gcolor: = Color.blue

export var song: String

# TODO Finish level
# Make the initial_speedbost and initial_vehicle work. There are still some fields
# that are missing, such as the song audio file, the background and ground texture.
export var initial_speedboost: = 1
export({cube=0, ship=1, ball=2, ufo=3, wave=4, robot=5, spider=6}) var initial_vehicle: = 0

# TODO level completion
# level_length will be used to spawn the win wall at the end of the level
var level_length: = 0.0 # the total length (in pixels) of the level width

func _ready () -> void:
	if song:
		Jukebox.playing_song = load (song)
	
	PlayerData.bgcolor = initial_bgcolor
	PlayerData.gcolor = initial_gcolor
	
	# iterate through all the tiles, so we get the farthest tile
	var tiles: = [$SolidTiles, $TrapTiles, $SpecialTiles]
	
	for i in tiles:
		var tile: TileMap = i
		var len_rect: = tile.get_used_rect ()
		var total_len: = (len_rect.position.x + len_rect.size.x) * tile.cell_size.x
		if total_len > level_length:
			level_length = total_len
	
	win_wall.position.x = level_length + (60 * 3)
	camera.limit_right = win_wall.position.x
	
	win_wall_area.connect ("body_entered", self, "win_level")

func win_level (body: Node) -> void:
	Jukebox.stop_song ()
	
	if not GameData.playing_level:
		return
	
	if GameData.playing_level.is_local:
		if GameData.playing_level.id + 1 > GameData.data.level_world:
			# TODO Give rewards
			GameData.data.level_world = GameData.playing_level.id + 1
			print ("TODO Give rewards")
	else:
		# TODO Win online levels
		# How will I handle wining online levels? :O
		pass
	
	# TODO Display a win screen
	# Instead of directly going to the previous scene, show
	# some kind of display screen, or something like that
	get_tree ().change_scene (GameData.playing_level.from_scene)

func _process (delta: float) -> void:
	background.modulate = PlayerData.bgcolor
	win_wall.position.y = PlayerData.g1y - 540
