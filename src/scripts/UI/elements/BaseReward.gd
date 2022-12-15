extends NinePatchRect

export var icon: Texture
export var amount: String setget set_amount
export var taken: = false setget set_taken

func _ready () -> void:
	if icon:
		$Icon.texture = icon
		$Icon.rect_size = Vector2 (icon.get_width (), icon.get_width ())
		
		if $Icon.rect_size.y > 72:
			$Icon.rect_size *= 72 / $Icon.rect_size.y
			
			$Icon.rect_position.x = (rect_size.x / 2) - ($Icon.rect_size.x / 2)
	
	$Amount.text = amount
	$IconCheck.visible = taken

func set_amount (_amount: String) -> void:
	amount = _amount
	$Amount.text = _amount

func set_taken (_taken: bool) -> void:
	taken = _taken
	$IconCheck.visible = _taken
