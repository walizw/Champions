extends GDButton

signal callback

func _on_button_down () -> void:
	mouse_down (self)

func _on_button_up() -> void:
	_release_anim (self)
	
	if not tween:
		return
	
	emit_signal ("callback")
