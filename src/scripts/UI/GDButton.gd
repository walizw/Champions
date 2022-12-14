extends TextureButton
class_name GDButton

export var play_anim: = true

var tween: SceneTreeTween
var initial_scale: = Vector2.ZERO

func _ready () -> void:
	rect_pivot_offset = rect_size / 2
	initial_scale = rect_scale

func mouse_down (object: Object) -> void:
	if not play_anim:
		return
	
	if tween:
		tween.stop ()
	
	tween = create_tween ().set_trans (Tween.TRANS_SINE)
	tween.tween_property (object, "rect_scale", initial_scale * 1.2, 0.07)
	tween.tween_property (object, "rect_scale", initial_scale * 1.1, 0.007)
	tween.tween_property (object, "rect_scale", initial_scale * 1.2, 0.04)

func _release_anim (object: Object) -> void:
	if not play_anim:
		return
	
	if tween:
		tween.stop ()
	
	tween = create_tween ().set_trans (Tween.TRANS_SINE)
	tween.tween_property (object, "rect_scale", initial_scale, 0.15)
