extends Control

onready var login_popup: = $LoginPopup
onready var dark_rect: = $DarkRect

func _ready () -> void:
	if not GameData.jwt:
		login_popup.popup_centered ()
		dark_rect.visible = true

# TODO Press anywhere on the screen to continue
# When the user presses anywhere on the screen (and there is a JWT) go to the
# lobby.
