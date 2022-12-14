extends Control

onready var login_popup: = $LoginPopup
onready var dark_rect: = $DarkRect

func _ready () -> void:
	if not GameData.jwt:
		login_popup.popup_centered ()
		dark_rect.visible = true

func _process (delta: float) -> void:
	if Input.is_action_pressed ("jump") and GameData.jwt:
		var lobby_scene: = preload ("res://scenes/UI/Lobby.tscn")
		get_tree ().change_scene_to (lobby_scene)
