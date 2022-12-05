extends Node

onready var audio_player: = $AudioPlayer
onready var background: = get_node ("BackgroundLayer/Background")

func _ready () -> void:
	play_song ()

func play_song () -> void:
	var time_delay: = AudioServer.get_time_to_next_mix () + AudioServer.get_output_latency ()
	yield (get_tree ().create_timer (time_delay), "timeout")
	
	audio_player.play ()

func _process (delta: float) -> void:
	background.modulate = PlayerData.bgcolor
	background.position.x += (PlayerData.speed.x * PlayerData.speed_boost) * delta
