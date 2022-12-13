extends Node

var api_url: = "http://localhost:8000/api/v1/"
var use_ssl: = false

var jwt: = "" setget set_jwt
var refresh: = "" # the refresh token

# TODO Saving and loading game
# Is it really necessary to save and load the entire data from a file?
# Why not just the jwt? if there's a save file we'll load its jwt and
# set it to `self.jwt' so `set_jwt' is called and the data is retrieved
# from the cloud
func from_file () -> void:
	pass

func to_file () -> void:
	pass

func set_jwt (_jwt: String) -> void:
	jwt = _jwt
	
	# TODO Retrieve user info
	# Now that we have the JWT and the user is successfully logged in,
	# we have to perform another query to get the user's data.
