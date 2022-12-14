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

# TODO Generate stage UI
# For each level create a child that is basically a button
# with a label (its id + 1) and it must also have a popup
# that shows the info (its rewards, its name) and a button
# to play. This popup is shown when clicked the button.
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
	
	level_popup_name.text = level.name
	level_popup_play.to_scene = level.to_scene
	level_popup_play.connect ("callback", self, "play_level")
	level_popup_energy.text = str (level.energy_cost)
	
	level_popup.popup ()

func play_level () -> void:
	GameData.data.energy -= selected_level.energy_cost
	GameData.playing_level = selected_level
	GameData.playing_level.from_scene = get_tree ().current_scene.filename
