extends Control

onready var camera: = get_node ("../Camera")

onready var level_name: = $LevelName

onready var continue_btn: = $ButtonsContainer/ContinueButton
onready var restart_btn: = $ButtonsContainer/RestartButton
onready var giveup_btn: = $ButtonsContainer/GiveUpButton

var playing_level: LevelData

func _ready () -> void:
	visible = false
	
	continue_btn.connect ("callback", self, "_continue_callback")
	restart_btn.connect ("callback", self, "_restart_callback")
	giveup_btn.connect ("callback", self, "_giveup_callback")
	
	if GameData.playing_level:
		playing_level = GameData.playing_level

func _process (delta: float) -> void:
	if Input.is_action_just_pressed ("pause"):
		get_tree ().paused = !get_tree ().paused
		visible = get_tree ().paused
		
		if playing_level:
			level_name.text = playing_level.name
		
		rect_scale = Vector2 (camera.zoom.x + 0.05, camera.zoom.y + 0.05)
		rect_position = camera.global_position - ((get_viewport ().size * camera.zoom) / 2)
		rect_position.x = clamp (rect_position.x, camera.limit_left, rect_position.x)

func _continue_callback () -> void:
	visible = false
	get_tree ().paused = false

func _restart_callback () -> void:
	get_tree ().reload_current_scene ()
	get_tree ().paused = false

func _giveup_callback () -> void:
	var prev_scene: = GameData.prev_scene
	
	if prev_scene:
		get_tree ().paused = false
		Jukebox.stop_song ()
		get_tree ().change_scene (prev_scene)
