extends Control

export var stage_name: = ""
export (Array, Resource) var levels: Array

var level_tile: = preload ("res://prefabs/UI/elements/LevelTile.tscn")

var selected_level: LevelData

onready var stage_label: = $TopRightContainer/StageLabel
onready var levels_container: = $LevelsScroll/VBoxContainer/LevelsContainer

onready var level_popup: = $LevelPopup
onready var level_popup_name: = $LevelPopup/LevelLabel
onready var level_popup_rewards_cnt: = $LevelPopup/RewardsContainer
onready var level_popup_play: = $LevelPopup/ButtonsContainer/PlayButton
onready var level_popup_energy: = $LevelPopup/ButtonsContainer/PlayButton/EnergyCostLabel

func _ready () -> void:
	stage_label.text = stage_name
	
	generate_ui ()

func generate_ui () -> void:
	for i in levels:
		var level: LevelData = i
		
		var tile_instance: = level_tile.instance ()
		tile_instance.level = level
		
		if GameData.data.level_world < level.id:
			tile_instance.disabled = true
		
		levels_container.add_child (tile_instance)
		tile_instance.connect ("callback", self, "display_level_popup")

func display_level_popup (level: LevelData) -> void:
	selected_level = level
	clean_rewards ()
	
	level_popup_name.text = level.name
	level_popup_play.to_scene = level.to_scene
	level_popup_play.connect ("callback", self, "play_level")
	level_popup_energy.text = str (level.energy_cost)
	
	create_rewards ()
	
	level_popup.popup ()

func clean_rewards () -> void:
	var rewards_container: = $LevelPopup/RewardsContainer
	
	for i in rewards_container.get_children ():
		i.queue_free ()

func create_rewards () -> void:
	var base_reward: = load ("res://prefabs/UI/elements/BaseReward.tscn")
	
	for i in selected_level.rewards:
		var reward: = i as LevelReward
		var ins = base_reward.instance ()
		
		if reward.type == 1:
			ins.icon = load ("res://assets/ui/icons/IconCoin.png")
		elif reward.type == 2:
			ins.icon = load ("res://assets/ui/icons/IconGem.png")
		elif reward.type == 3:
			ins.icon = load ("res://assets/ui/icons/IconEnergyYellow.png")
		elif reward.type == 4:
			ins.icon = load ("res://assets/ui/icons/IconStar.png")
		
		ins.amount = reward.amount
		level_popup_rewards_cnt.add_child (ins)

func play_level () -> void:
	GameData.data.energy -= selected_level.energy_cost
	GameData.playing_level = selected_level
	GameData.playing_level.from_scene = get_tree ().current_scene.filename
