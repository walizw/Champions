# This is used for playing music (and sounds)
extends Node

# TODO Jukebox
# Add a function to play another audio (such as a level song) and when
# that audio is stopped (or finished) the loop will start playing again.

var audio_stream: AudioStreamPlayer
var loop_song: = preload ("res://assets/songs/Floating in the Abyss - Menu Loop.wav")

func _ready () -> void:
	audio_stream = AudioStreamPlayer.new ()
	add_child (audio_stream)
	
	audio_stream.stream = loop_song
	audio_stream.play ()
