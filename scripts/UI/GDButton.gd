extends TextureButton
class_name GDButton

var tween: SceneTreeTween
var initial_scale: = rect_scale

func _ready () -> void:
	rect_pivot_offset = rect_size / 2

func mouse_down (object: Object) -> void:
	if tween:
		tween.stop ()
	
	tween = create_tween ().set_trans (Tween.TRANS_SINE)
	tween.tween_property (object, "rect_scale", initial_scale * 1.2, 0.2)
	tween.tween_property (object, "rect_scale", initial_scale * 1.1, 0.07)
	tween.tween_property (object, "rect_scale", initial_scale * 1.2, 0.1)

func _release_anim (object: Object) -> void:
	if tween:
		tween.stop ()
	
	tween = create_tween ().set_trans (Tween.TRANS_SINE)
	tween.tween_property (object, "rect_scale", initial_scale, 0.15)
