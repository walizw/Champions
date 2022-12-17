# This is used for playing music (and sounds)
extends Node

# TODO Jukebox
# Add a function to play another audio (such as a level song) and when
# that audio is stopped (or finished) the loop will start playing again.

var song_play: AudioStreamPlayer
var audio_play: AudioStreamPlayer

var playing_song: Resource setget play_song
var playing_audio: Resource setget play_audio

var loop_song: = preload ("res://assets/songs/Floating in the Abyss - Menu Loop.wav")

func _ready () -> void:
	song_play = AudioStreamPlayer.new ()
	audio_play = AudioStreamPlayer.new ()
	
	add_child (song_play)
	add_child (audio_play)
	
	self.playing_song = loop_song

func play_song (song: Resource) -> void:
	if song_play.stream_paused:
		song_play.stream_paused = false
	
	playing_song = song
	song_play.stream = song
	song_play.play ()

func pause_song () -> void:
	song_play.stream_paused = true

func resume_song () -> void:
	song_play.stream_paused = false

func stop_song () -> void:
	song_play.stop ()
	
	self.playing_song = loop_song

func play_audio (audio: Resource) -> void:
	playing_audio = audio
	audio_play.stream = audio
	audio_play.play ()
