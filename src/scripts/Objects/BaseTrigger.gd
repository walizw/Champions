class_name BaseTrigger
extends Area2D

export var on_touch: = false # if true, the player must collide with the exact position of this trigger
export var time: = 0.0 # useful if this trigger has some time measure

var trans: = Tween.TRANS_SINE

func _ready () -> void:
	if not on_touch:
		scale.y = 2000
	visible = false # we will make it inivisible, in case there's a sprite attached to it
