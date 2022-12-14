extends Control

export var stage_name: = ""
export (Array, Resource) var levels: Array

onready var stage_label: = $TopRightContainer/StageLabel
onready var levels_container: = $LevelsContainer

func _ready () -> void:
	stage_label.text = stage_name
	generate_ui ()

# TODO Generate stage UI
# For each level create a child that is basically a button
# with a label (its id + 1) and it must also have a popup
# that shows the info (its rewards, its name) and a button
# to play. This popup is shown when clicked the button.
func generate_ui () -> void:
	pass
