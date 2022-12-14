extends Popup

onready var username_label: = $LabelsContainer/Username
onready var pass1_label: = $LabelsContainer/Password
onready var pass2_label: = $LabelsContainer/Password2
onready var signup_button: = $SignupButton
onready var signup_request: = $SignupRequest

func _ready () -> void:
	signup_button.connect ("callback", self, "_signup")
	signup_request.connect ("request_completed", self, "_on_request_completed")

func _signup () -> void:
	var username: String = username_label.text
	var pass1: String = pass1_label.text
	var pass2: String = pass2_label.text
	
	if not username or not pass1 or not pass2:
		GameData.create_accept_popup ("Error", "Please fill all the fields")
		return
	
	if pass1 != pass2:
		GameData.create_accept_popup ("Error", "The entered passwords do not match")
		return
	
	var endpoint: = GameData.api_url + "users/create/"
	var headers: = ["Content-Type: application/json"]
	var data: = JSON.print ({
		"username": username,
		"password": pass1,
		"password2": pass2
	})
	signup_request.request (endpoint, headers, GameData.use_ssl, HTTPClient.METHOD_POST, data)
	
func _on_request_completed (result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		GameData.create_accept_popup ("Error", "There's been an error signing you up")
		return
	
	if response_code < 300:
		GameData.create_accept_popup ("Success", "Your account has been created successfully.\nYou can log in now.")
		visible = false
	else:
		GameData.create_accept_popup ("Error", body.get_string_from_utf8 ())
