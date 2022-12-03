# A button that activates a popup
extends GDButton

export var popup: NodePath
export var size: Vector2 = Vector2.ZERO

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
		if not popup:
			return
		
		var popup_instance: Popup = get_node (popup)
		popup_instance.popup_centered (size)
		#get_tree ().change_scene_to (to_scene)
