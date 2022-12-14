# taken from: https://github.com/godotengine/godot/issues/21137#issuecomment-474598933
extends ScrollContainer
class_name DragScroll

var swiping: = false
var swipe_start: = Vector2.ZERO
var swipe_mouse_start: = Vector2.ZERO
var swipe_mouse_times: = []
var swipe_mouse_positions: = []

func _input (event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			swiping = true
			swipe_start = Vector2 (get_h_scroll (), get_v_scroll ())
			swipe_mouse_start = event.position
			swipe_mouse_times = [OS.get_ticks_msec ()]
			swipe_mouse_positions = [swipe_mouse_start]
		else:
			swipe_mouse_times.append (OS.get_ticks_msec ())
			swipe_mouse_positions.append (event.position)
			
			var source: = Vector2 (get_h_scroll (), get_v_scroll ())
			var idx: = swipe_mouse_times.size () - 1
			var now: = OS.get_ticks_msec ()
			var cutoff: = now - 100
			for i in range (swipe_mouse_times.size () - 1, -1, -1):
				if swipe_mouse_times [i] >= cutoff:
					idx = i
				else:
					break
			
			var flick_start: Vector2 = swipe_mouse_positions [idx]
			var flick_dur: = min (0.3, (event.position - flick_start).length () / 1000)
			if flick_dur > 0.0:
				var tween: = create_tween ().set_trans (Tween.TRANS_LINEAR).set_ease (Tween.EASE_OUT)
				var delta: Vector2 = event.position - flick_start
				var target: = source - delta * flick_dur * 15.0
				
				tween.tween_method (self, "set_h_scroll", source.x, target.x, flick_dur)
				tween.tween_method (self, "set_v_scroll", source.y, target.y, flick_dur)
				tween.tween_callback (tween, "queue_free")
			swiping = false
	elif swiping and event is InputEventMouseMotion:
		var delta: Vector2 = event.position - swipe_mouse_start
		set_h_scroll (swipe_start.x - delta.x)
		set_v_scroll (swipe_start.y - delta.y)
		swipe_mouse_times.append (OS.get_ticks_msec ())
		swipe_mouse_positions.append (event.position)
