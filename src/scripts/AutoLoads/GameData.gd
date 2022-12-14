extends Node

signal data_changed

# Server-side stuff
var api_url: = "http://localhost:8000/api/v1/"
var use_ssl: = false

# Session handling
var jwt: = "" setget set_jwt
var refresh: = "" # the refresh token

var http_req: HTTPRequest

# Player saved data
var data: = {
	"player_name": "Player",
	"level": 0,
	"exp": 0,
	"player_next_experience": 0, # exp for next level
	
	"cube": 0,
	"ship": 0,
	"ball": 0,
	"ufo": 0,
	"wave": 0,
	"robot": 0,
	"spider": 0,
	
	"col_a": Color.yellow,
	"col_b": Color.aqua,
	
	"level_world": 0 # the level we're at (as levels must be completed sequencially)
}

func _ready () -> void:
	from_file ()

func from_file () -> void:
	var save_game = File.new ()
	if not save_game.file_exists ("user://savegame.save"):
		return
	
	save_game.open ("user://savegame.save", File.READ)
	var data: = JSON.parse (save_game.get_as_text ())
	
	self.jwt = data.result.jwt
	refresh = data.result.refresh
	
	# TODO Refrest the access token at jwt load
	
	save_game.close ()

func to_file () -> void:
	var save_game = File.new ()
	save_game.open ("user://savegame.save", File.WRITE)
	save_game.store_string (to_json ({
		"jwt": jwt,
		"refresh": refresh
	}))
	save_game.close ()

func set_jwt (_jwt: String) -> void:
	jwt = _jwt
	
	http_req = HTTPRequest.new ()
	add_child (http_req)
	http_req.connect ("request_completed", self, "get_user_data")
	
	var endpoint: = api_url + "user/"
	var headers: = ["Authorization: Bearer %s" % _jwt]
	http_req.request (endpoint, headers, use_ssl, HTTPClient.METHOD_GET)

func get_user_data (result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		create_accept_popup ("Error", "There's been an error getting your cloud saves.")
		return
	
	if response_code == 401:
		GameData.create_accept_popup ("Error", "There's been an error with your access token.")
		return
	
	var response: = JSON.parse (body.get_string_from_utf8 ())
	var response_data = response.result.data
	
	data.player_name = response.result.username
	data_from_dict (response_data)
	
	http_req.queue_free ()

func data_from_dict (input: Dictionary) -> void:
	data.level = int (input.level)
	data.exp = int (input.exp)
	
	data.player_next_experience = (data.level + 1) * 100
	
	data.col_a = Color (input.col_a)
	data.col_b = Color (input.col_b)
	
	data.cube = int (input.cube)
	data.ship = int (input.ship)
	data.ball = int (input.ball)
	data.ufo = int (input.ufo)
	data.wave = int (input.wave)
	data.robot = int (input.robot)
	data.spider = int (input.spider)
	
	emit_signal ("data_changed")

func create_accept_popup (title: String, content: String) -> void:
	var dialog_resource: = preload ("res://prefabs/UI/elements/AcceptPopup.tscn")
	var err_dialog: AcceptPopup = dialog_resource.instance ()
	err_dialog.title = title
	err_dialog.text = content
	get_tree ().root.add_child (err_dialog)
	err_dialog.popup_centered ()