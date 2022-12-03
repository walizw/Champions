extends Control
# TODO: Play the song

onready var background: = $BackgroundLayer/Background
onready var ground: = $GroundLayer/Ground

var current_color: Color = Color.blue
var other_color: Color = Color.magenta
var color_mix: = 0.5
var color_dir: = 1

func _process (delta: float) -> void:
	current_color = Color.linear_interpolate (Color.blend (other_color), color_mix)
	if color_mix >= 1 or color_mix <= 0.4:
		color_dir *= -1
		randomize ()
		other_color = Color (randf (), randf (), randf ())
	color_mix += 0.0025 * color_dir
	
	background.modulate = current_color
	ground.modulate = current_color
