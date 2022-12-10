extends GDButton

signal callback

func _on_button_down () -> void:
	mouse_down (self)

func _on_button_up() -> void:
	_release_anim (self)
	
	if not tween:
		return
	
	if Rect2 (rect_global_position, rect_size).has_point (get_global_mouse_position ()):
		emit_signal ("callback")
