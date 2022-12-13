extends Popup
class_name AcceptPopup

export var title: = ""
export var text: = ""

onready var title_label: = $Title
onready var content_label: = $Content
onready var close_button: = $CloseButton

func _ready () -> void:
	title_label.text = title
	content_label.text = text
	
	close_button.connect ("callback", self, "close")

func close () -> void:
	queue_free ()
