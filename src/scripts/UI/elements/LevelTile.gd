extends GDButton
signal callback

export var is_extra: = false
export var is_active: = false

var level: LevelData

onready var tex: = $Texture
onready var tex_disabled: = $TextureDisabled
onready var tex_selected: = $TextureSelected
onready var tex_extra: = $TextureExtra

onready var id_label: = $NumberLabel

func _ready () -> void:
	if disabled:
		tex_disabled.visible = true
	elif is_extra:
		tex_extra.visible = true
	elif is_active:
		tex_selected.visible = true
	else:
		tex.visible = true
	
	if not level:
		return
	
	id_label.text = str (level.id + 1)

func _on_button_down() -> void:
	mouse_down (self)

func _on_button_up() -> void:
	_release_anim (self)
	
	if tween:
		yield (tween, "finished")
	
	if Rect2 (rect_global_position, rect_size).has_point (get_global_mouse_position ()):
		emit_signal ("callback", level)
