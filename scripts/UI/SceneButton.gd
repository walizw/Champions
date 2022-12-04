# A button that changes the scene to a different one when pressed
extends GDButton

export (String, FILE, "*.tscn") var to_scene

func _ready () -> void:
	rect_pivot_offset = rect_size / 2

func _on_button_down () -> void:
	mouse_down (self)

func _on_button_up () -> void:
	_release_anim (self)
	
	if not tween:
		return
	
	yield (tween, "finished")
	if Rect2 (rect_position, rect_size).has_point (get_global_mouse_position ()):
		if not to_scene:
			return
		
		if ResourceLoader.exists (to_scene):
			get_tree ().change_scene (to_scene)
