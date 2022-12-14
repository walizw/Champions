extends Popup

onready var username_label: = $LabelsContainer/Username
onready var password_label: = $LabelsContainer/Password

onready var login_button: = $LoginButton
onready var signup_button: = $SignupButton

onready var signup_popup = $SignupPopup
onready var login_request: = $LoginRequest

func _ready () -> void:
	login_button.connect ("callback", self, "_login")
	signup_button.connect ("callback", self, "_show_signup")
	
	login_request.connect ("request_completed", self, "_on_request_completed")

func _login () -> void:
	var username: String = username_label.text
	var password: String = password_label.text
	
	if not username or not password:
		GameData.create_accept_popup ("Error", "Please fill all the fields!")
		return
	
	var endpoint: = GameData.api_url + "token/"
	var headers: = ["Content-Type: application/json"]
	var data: = JSON.print ({
		"username": username,
		"password": password
	})
	login_request.request (endpoint, headers, GameData.use_ssl, HTTPClient.METHOD_POST, data)

func _show_signup () -> void:
	signup_popup.popup_centered ()

func _on_request_completed (result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		GameData.create_accept_popup ("Error", "There's been an error with the login ")
		return
	
	if response_code == 401:
		GameData.create_accept_popup ("Error", "Invalid credentials!")
		return
	
	var response: = JSON.parse (body.get_string_from_utf8 ())
	GameData.jwt = response.result.access
	GameData.refresh = response.result.refresh
	
	get_node ("/root/Loading/DarkRect").visible = false
	GameData.to_file ()
	queue_free () # We've successfully logged in
