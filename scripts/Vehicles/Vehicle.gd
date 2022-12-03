extends KinematicBody2D
class_name Vehicle

var velocity: = Vector2.ZERO

onready var spr_a: = $SprA
onready var spr_b: = $SprB

onready var camera: = $Camera2D

var angle: = 0.0

func _ready () -> void:
	camera.current = true
	
	spr_a.modulate = PlayerData.color_a
	spr_b.modulate = PlayerData.color_b

func _physics_process (delta: float) -> void:
	if is_on_wall () or is_on_ceiling():
		die ()
	
	# TODO: This might give errors in the ship
	if Input.is_action_just_pressed ("jump") and not is_on_floor ():
		PlayerData.canring = true
	
	if PlayerData.canring and is_on_floor ():
		PlayerData.canring = false
	
	move_vehicle (delta)

func move_vehicle (delta: float) -> void:
	velocity.x = PlayerData.speed.x * PlayerData.speed_boost
	velocity.y += (PlayerData.grav * delta) * PlayerData.gravdir

func die () -> void:
	# TODO: Die
	# queue_free ()
	get_tree ().paused = true

func handle_special (tile_id: int, pos: Vector2) -> void:
	if tile_id == -1:
		print ("handle_special: Received a -1, should we fix this? how tho?")
		return
	
	if tile_id == TileData.SPECIAL_TILE_RING_YELLOW and PlayerData.canring:
		velocity.y = - PlayerData.speed.y * PlayerData.gravdir
		PlayerData.canring = false
	elif tile_id == TileData.SPECIAL_TILE_RING_PINK and PlayerData.canring:
		velocity.y = - (PlayerData.speed.y - (PlayerData.speed.y * 0.1)) * PlayerData.gravdir
		PlayerData.canring = false
	elif tile_id == TileData.SPECIAL_TILE_RING_BLUE and PlayerData.canring:
		PlayerData.gravdir *= -1
		velocity.y = PlayerData.speed.y * PlayerData.gravdir
		PlayerData.canring = false
	elif tile_id == TileData.SPECIAL_TILE_RING_ORANGE and PlayerData.canring:
		velocity.y = -(PlayerData.speed.y + (PlayerData.speed.y * 0.2)) * PlayerData.gravdir
		PlayerData.canring = false
	elif tile_id == TileData.SPECIAL_TILE_RING_GREEN and PlayerData.canring:
		PlayerData.gravdir *= -1
		velocity.y = -PlayerData.speed.y * PlayerData.gravdir
		PlayerData.canring = false
	
	elif tile_id == TileData.SPECIAL_TILE_DASH_GREEN and PlayerData.canring:
		# TODO: Dash
		PlayerData.canring = false
	elif tile_id == TileData.SPECIAL_TILE_DASH_PINK and PlayerData.canring:
		# TODO: Dash
		PlayerData.canring = false
	
	elif tile_id == TileData.SPECIAL_TILE_BUMP_YELLOW:
		velocity.y = -(PlayerData.speed.y * 1.5) * PlayerData.gravdir
	elif tile_id == TileData.SPECIAL_TILE_BUMP_PINK:
		velocity.y = -(PlayerData.speed.y - (PlayerData.speed.y * 0.1)) * PlayerData.gravdir
	elif tile_id == TileData.SPECIAL_TILE_BUMP_BLUE:
		PlayerData.gravdir *= -1
		velocity.y = PlayerData.speed.y * PlayerData.gravdir
	elif tile_id == TileData.SPECIAL_TILE_BUMP_ORANGE:
		velocity.y = -(PlayerData.speed.y + (PlayerData.speed.y * 0.8)) * PlayerData.gravdir
	
	# TODO: Portals
	elif tile_id == TileData.SPECIAL_TILE_PORTAL_CUBE:
		pass
	elif tile_id == TileData.SPECIAL_TILE_PORTAL_SHIP:
		PlayerData.vehicle_transform (self, "res://prefabs/Ship.tscn")
		PlayerData.calc_ground_y (pos, 13)
