extends Control

onready var player_name: = $TopLeftContainer/Level/PlayerName
onready var player_level: = $TopLeftContainer/Level/LevelFrame/LevelLabel
onready var player_exp: = $TopLeftContainer/Level/ExpBar/ExpLabel
onready var player_exp_bar = $TopLeftContainer/Level/ExpBar

func _process (delta: float) -> void:
	player_name.text = GameData.player_name
	player_level.text = str (GameData.data.level)
	player_exp.text = "%d/%d" % [GameData.data.exp, GameData.data.player_next_experience]
	
	player_exp_bar.max_value = GameData.data.player_next_experience
	player_exp_bar.value = GameData.data.exp
