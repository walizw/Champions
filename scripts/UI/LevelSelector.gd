extends Control

export (Array, Resource) var levels: Array
export var main_level_tile: PackedScene

onready var prev_level_btn: = get_node ("../PrevLevel")
onready var next_level_btn: = get_node ("../NextLevel")

var level_tiles: = []
var in_level: = 0

func _ready () -> void:
	generate_tiles ()
	
	prev_level_btn.connect ("callback", self, "prev_level")
	next_level_btn.connect ("callback", self, "next_level")

func _process (delta: float) -> void:
	if Input.is_action_just_pressed ("left"):
		prev_level ()
	elif Input.is_action_just_pressed ("right"):
		next_level ()

func next_level () -> void:
	in_level += 1
	level_anim (1)

func prev_level () -> void:
	if in_level == 0:
		return
	
	in_level -= 1
	level_anim (-1)

func level_anim (dir: int) -> void:
	if in_level < 0:
		restart_carousel (false)
	elif in_level >= level_tiles.size ():
		restart_carousel (true)
	
	for i in level_tiles.size ():
		var level_tile: MainLevelTile = level_tiles [i]
		var tween: = create_tween ().set_trans (Tween.TRANS_SINE)
		# TODO: Fix this
		var new_position: = Vector2 (level_tile.rect_position.x - (1920 * dir), level_tile.rect_position.y)
		tween.tween_property (level_tile, "rect_position", Vector2 (new_position.x - (120 * dir), new_position.y), 0.175)
		tween.tween_property (level_tile, "rect_position", Vector2 (new_position.x + (120 * dir), new_position.y), 0.083)
		tween.tween_property (level_tile, "rect_position", new_position, 0.085)

func restart_carousel (first: bool) -> void:
	# TODO: Restart left
	
	in_level = 0
	var offset: = 1920
	
	for i in level_tiles.size ():
		var level_tile: MainLevelTile = level_tiles [i]
		level_tile.rect_position.x = offset
		offset += 1920

func generate_tiles () -> void:
	var offset: = 0.0
	
	for i in levels.size ():
		var level_data: LevelData = levels [i]
		var level_tile: MainLevelTile = main_level_tile.instance ()
		level_tile.level_data = level_data
		level_tiles.append (level_tile)
		
		level_tile.rect_position = Vector2 (offset, -160)
		offset += 1920
		
		add_child (level_tile)
