extends Control
# TODO: Play the song

onready var background: = $BackgroundLayer/Background
onready var ground: = $GroundLayer/Ground

var tween: SceneTreeTween

func _ready () -> void:
	change_col ()

func change_col () -> void:
	if tween:
		tween.stop ()
	
	randomize ()
	tween = create_tween ().set_trans (Tween.TRANS_SINE)
	var col: Color = Color (randf (), randf (), randf ())
	tween.tween_property (background, "modulate", col, 5)
	tween.parallel ().tween_property (ground, "modulate", col, 5)
	yield (tween, "finished")
	change_col ()
