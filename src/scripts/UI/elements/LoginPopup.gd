extends Popup

onready var username_label: = $LabelsContainer/Username
onready var password_label: = $LabelsContainer/Password

onready var login_button: = $LoginButton
onready var signup_button: = $SignupButton

onready var login_request: = $LoginRequest

func _ready () -> void:
	login_button.connect ("callback", self, "_login")
	signup_button.connect ("callback", self, "_show_signup")
	
	login_request.connect ("request_completed", self, "_on_request_completed")

func _login () -> void:
	# TODO Login
	# Login a user with the `username_label.text' and `password_label.text'
	# credentials, if they are correct, a JWT is returned and must be stored in
	# GameData so it can be saved in a resource file.
	var username: String = username_label.text
	var password: String = password_label.text
	
	if not username or not password:
		create_accept_popup ("Error", "Please fill all the fields!")
		return
	
	var endpoint: = GameData.api_url + "token/"
	var headers: = ["Content-Type: application/json"]
	var data: = JSON.print ({
		"username": username,
		"password": password
	})
	login_request.request (endpoint, headers, GameData.use_ssl, HTTPClient.METHOD_POST, data)

func _show_signup () -> void:
	# TODO Signup popup
	# Show a signup popup when the "Signup" button is pressed.
	print ("TODO: Show signup popup")

func _on_request_completed (result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		create_accept_popup ("Error", "There's been an error with the login ")
		return
	
	if response_code == 401:
		create_accept_popup ("Error", "Invalid credentials!")
		return
	
	var response: = JSON.parse (body.get_string_from_utf8 ())
	GameData.jwt = response.result.access
	GameData.refresh = response.result.refresh
	
	get_node ("/root/Loading/DarkRect").visible = false
	queue_free () # We've successfully logged in

func create_accept_popup (title: String, content: String) -> void:
	var dialog_resource: = preload ("res://prefabs/UI/elements/AcceptPopup.tscn")
	var err_dialog: AcceptPopup = dialog_resource.instance ()
	err_dialog.title = title
	err_dialog.text = content
	get_tree ().root.add_child (err_dialog)
	err_dialog.popup_centered ()
