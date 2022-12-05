# A button that activates a popup
extends GDButton

export var popup: NodePath
export var size: Vector2 = Vector2.ZERO

func _on_button_down () -> void:
	mouse_down (self)

func _on_button_up () -> void:
	_release_anim (self)
	
	if not tween:
		return
	
	yield (tween, "finished")
	if not popup:
		return
	
	var popup_instance: Popup = get_node (popup)
	popup_instance.popup_centered (size)
