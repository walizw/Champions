extends Node

onready var audio_player: = $AudioPlayer
onready var background: = $ParallaxBackground/ParallaxLayer/Background

export var initial_bgcolor: = Color.blue
export var initial_gcolor: = Color.blue

func _ready () -> void:
	yield (self, "ready")
	play_song ()
	
	PlayerData.bgcolor = initial_bgcolor
	PlayerData.gcolor = initial_gcolor

func play_song () -> void:
	var time_delay: = AudioServer.get_time_to_next_mix () + AudioServer.get_output_latency ()
	yield (get_tree ().create_timer (time_delay), "timeout")
	
	audio_player.play ()

func _process (delta: float) -> void:
	background.modulate = PlayerData.bgcolor
