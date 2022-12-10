extends BaseTrigger

export var to_col: = Color.blue

func _on_body_entered(body: Node) -> void:
	var tween: = get_tree ().create_tween ().set_trans (trans)
	tween.tween_property (PlayerData, "gcolor", to_col, time)
