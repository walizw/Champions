extends Control

onready var player_name: = $TopLeftContainer/Level/PlayerName
onready var player_level: = $TopLeftContainer/Level/LevelFrame/LevelLabel
onready var player_exp: = $TopLeftContainer/Level/ExpBar/ExpLabel
onready var player_exp_bar = $TopLeftContainer/Level/ExpBar

func _ready () -> void:
	update_ui ()
	GameData.connect ("data_changed", self, "update_ui")

func update_ui () -> void:
	player_name.text = GameData.data.player_name
	player_level.text = str (GameData.data.player_level)
	player_exp.text = "%d/%d" % [GameData.data.player_experience, GameData.data.player_next_experience]
	
	player_exp_bar.max_value = GameData.data.player_next_experience
	player_exp_bar.value = GameData.data.player_experience
