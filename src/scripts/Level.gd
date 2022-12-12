extends Node

onready var audio_player: = $AudioPlayer
onready var background: = $ParallaxBackground/ParallaxLayer/Background

onready var win_wall: = $WinWall
onready var win_wall_area: = $WinWall/Area
onready var camera: = $Camera

export var initial_bgcolor: = Color.blue
export var initial_gcolor: = Color.blue

# TODO Finish level
# Make the initial_speedbost and initial_vehicle work. There are still some fields
# that are missing, such as the song audio file, the background and ground texture.
export var initial_speedboost: = 1
export({cube=0, ship=1, ball=2, ufo=3, wave=4, robot=5, spider=6}) var initial_vehicle: = 0

# TODO level completion
# level_length will be used to spawn the win wall at the end of the level
var level_length: = 0.0 # the total length (in pixels) of the level width

func _ready () -> void:
	yield (self, "ready")
	play_song ()
	
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
	# TODO Win Level
	# When this method is called, play an animation and update the GameData progress.
	# The variables such as the stars this levels gives must be stored somewhere, so they
	# are awarded to the player.
	print ("TODO Win Level")
	audio_player.stop ()

func play_song () -> void:
	var time_delay: = AudioServer.get_time_to_next_mix () + AudioServer.get_output_latency ()
	yield (get_tree ().create_timer (time_delay), "timeout")
	
	audio_player.play ()

func _process (delta: float) -> void:
	background.modulate = PlayerData.bgcolor
	win_wall.position.y = PlayerData.g1y - 540
