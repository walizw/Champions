extends Node

var levels: = [
	LevelData.new (
		"Stereo Madness",
		"res://scenes/Levels/StereoMadness.tscn",
		1, 1, 0.0, false
	),
	LevelData.new (
		"Back on Track",
		"res://scenes/Levels/BackOnTrack.tscn",
		2, 1, 0.0, false
	)
]

# TODO Level completion
# `player_level' represents the id (array index of `levels') of the level we're
# currently playing - only applies to local levels - so we can keep track of it
# in the `levels' array and store the player's progress and if it is completed
# or not
var player_level: = 0

# TODO Saving and loading game
# In levels only the percentage and completed should be loaded. But some variables
# from PlayerData must be saved, such as the frames for all the vehicles and the colours.

func from_file () -> void:
	pass

func to_file () -> void:
	pass
