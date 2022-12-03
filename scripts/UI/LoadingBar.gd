extends TextureProgress

export var next_scene: String

func _ready () -> void:
	yield (get_tree ().create_timer (0.5), "timeout")
	load_game ()

func load_game () -> void:
	var loader = ResourceLoader.load_interactive (next_scene)
	
	while true:
		var err = loader.poll ()
		if err == ERR_FILE_EOF:
			# loading complete
			var resource = loader.get_resource ()
			get_tree ().change_scene_to (resource)
			break
		elif err == OK:
			# loading
			var progress = float (loader.get_stage ()) / loader.get_stage_count ()
			value = progress * 100
		yield (get_tree (), "idle_frame")
