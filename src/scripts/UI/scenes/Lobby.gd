extends Control

onready var player_name: = $TopLeftContainer/Level/PlayerName
onready var player_level: = $TopLeftContainer/Level/LevelFrame/LevelLabel
onready var player_exp: = $TopLeftContainer/Level/ExpBar/ExpLabel
onready var player_exp_bar = $TopLeftContainer/Level/ExpBar

onready var energy_bar_total: = $TopRightContainer/EnergyBar/Total
onready var coin_bar_total: = $TopRightContainer/CoinBar/Total
onready var gem_bar_total: = $TopRightContainer/GemBar/Total

func _ready () -> void:
	update_ui ()

func _process (delta: float) -> void:
	update_ui ()

func update_ui () -> void:
	player_name.text = GameData.player_name
	player_level.text = str (GameData.data.level)
	player_exp.text = "%d/%d" % [GameData.data.exp, GameData.data.player_next_experience]
	
	player_exp_bar.max_value = GameData.data.player_next_experience
	player_exp_bar.value = GameData.data.exp
	
	energy_bar_total.text = "%d/%d" % [GameData.data.energy, GameData.data.max_energy]
	coin_bar_total.text = str (GameData.data.coins)
	gem_bar_total.text = str (GameData.data.gems)
