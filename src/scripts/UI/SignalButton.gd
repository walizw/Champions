extends GDButton

signal callback

export (String, FILE, "*.tscn") var to_scene

func _on_button_down() -> void:
	mouse_down (self)

func _on_button_up() -> void:
	_release_anim (self)
	
	if tween:
		yield (tween, "finished")
	
	if Rect2 (rect_global_position, rect_size).has_point (get_global_mouse_position ()):
		emit_signal ("callback")
		
		if not to_scene:
			return
		
		if ResourceLoader.exists (to_scene):
			get_tree ().change_scene (to_scene)
