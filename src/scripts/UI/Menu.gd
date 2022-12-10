extends Control

onready var background: = $BackgroundLayer/Background
onready var ground: = $GroundLayer/Ground

var tween: SceneTreeTween

func _ready () -> void:
	randomize ()
	var col: Color = Color (randf (), randf (), randf ())
	background.modulate = col
	ground.modulate = col
	change_col ()

func _process (delta: float) -> void:
	ground.region_rect.position.x += 400 * delta
	background.region_rect.position.x += 150 * delta

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
