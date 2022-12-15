extends NinePatchRect

export var icon: Texture
export var amount: int
export var taken: = false

func _ready () -> void:
	if icon:
		$Icon.texture = icon
		$Icon.rect_size = Vector2 (icon.get_width (), icon.get_width ())
		
		if $Icon.rect_size.y > 72:
			$Icon.rect_size *= 72 / $Icon.rect_size.y
			
			$Icon.rect_position.x = (rect_size.x / 2) - ($Icon.rect_size.x / 2)
	
	$Amount.text = str (amount)
	$IconCheck.visible = taken
