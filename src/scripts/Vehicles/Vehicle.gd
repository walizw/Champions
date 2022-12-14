extends KinematicBody2D
class_name Vehicle

var speed: = Vector2 (615, 1200)
var grav: = 5600 # gravity
var canring: = false # if true, and collided with a ring, do its thing?

var velocity: = Vector2.ZERO

onready var spr_a: = $SprA
onready var spr_b: = $SprB
onready var floor_particles: = $FloorParticles
onready var _trail: = $Trail

var angle: = 0.0
var trail: = false setget set_trail

var maxvsp: = 5000

func _ready () -> void:
	spr_a.modulate = GameData.data.col_a
	spr_b.modulate = GameData.data.col_b
	floor_particles.modulate = GameData.data.col_b
	
	_trail.default_color = GameData.data.col_b
	_trail.default_color.a = 0.25
	_trail.is_emitting = false

func _physics_process (delta: float) -> void:
	if is_on_wall ():# or is_on_ceiling():
		die ()
	
	move_vehicle (delta)
	
	floor_particles.emitting = is_on_floor ()
	
	# TODO The way orbs are handled might give errors on the ship
	# As canring might always be true, we should check in certain vehicles for
	# a click to set canring to true, only when colliding with an orb.
	if Input.is_action_just_pressed ("jump") and not is_on_floor ():
		canring = true
	
	if canring and is_on_floor ():
		canring = false

func move_vehicle (delta: float) -> void:
	velocity.x = speed.x * PlayerData.speed_boost
	velocity.y = clamp (velocity.y + ((grav * delta) * PlayerData.gravdir), -maxvsp, maxvsp)

func die () -> void:
	# TODO Die
	# Finish dying, death effect and respawning
	get_tree ().paused = true

func set_trail (trail_val: bool) -> void:
	trail = trail_val
	_trail.is_emitting = trail_val

func handle_special (tile_id: int, pos: Vector2) -> void:
	if tile_id == TileData.SPECIAL_TILE_RING_YELLOW and canring:
		velocity.y = -speed.y * PlayerData.gravdir
		canring = false
		self.trail = true
	elif tile_id == TileData.SPECIAL_TILE_RING_PINK and canring:
		velocity.y = - (speed.y - (speed.y * 0.1)) * PlayerData.gravdir
		canring = false
		self.trail = true
	elif tile_id == TileData.SPECIAL_TILE_RING_BLUE and canring:
		PlayerData.gravdir *= -1
		velocity.y = speed.y * PlayerData.gravdir
		canring = false
		self.trail = true
	elif tile_id == TileData.SPECIAL_TILE_RING_ORANGE and canring:
		velocity.y = -(speed.y + (speed.y * 0.2)) * PlayerData.gravdir
		canring = false
		self.trail = true
	elif tile_id == TileData.SPECIAL_TILE_RING_GREEN and canring:
		PlayerData.gravdir *= -1
		velocity.y = -speed.y * PlayerData.gravdir
		canring = false
		self.trail = true
	
	# TODO Dash orbs
	# Don't forget the fireboost :D
	elif tile_id == TileData.SPECIAL_TILE_DASH_GREEN and canring:
		canring = false
	elif tile_id == TileData.SPECIAL_TILE_DASH_PINK and canring:
		canring = false
	
	elif tile_id == TileData.SPECIAL_TILE_BUMP_YELLOW:
		velocity.y = -(speed.y * 1.35) * PlayerData.gravdir
		self.trail = true
	elif tile_id == TileData.SPECIAL_TILE_BUMP_PINK:
		velocity.y = -(speed.y - (speed.y * 0.1)) * PlayerData.gravdir
		self.trail = true
	elif tile_id == TileData.SPECIAL_TILE_BUMP_BLUE:
		PlayerData.gravdir *= -1
		self.trail = true
		velocity.y = speed.y * PlayerData.gravdir
	elif tile_id == TileData.SPECIAL_TILE_BUMP_ORANGE:
		velocity.y = -(speed.y + (speed.y * 0.8)) * PlayerData.gravdir
		self.trail = true
	
	# TODO Portals
	# Finish all the portals, the gravity portals, the mini portals, the teleportation
	# portals and well, the portals of all the vehicles
	elif tile_id == TileData.SPECIAL_TILE_PORTAL_CUBE:
		PlayerData.vehicle_transform (self, "Cube")
		PlayerData.reset_g2y ()
		PlayerData.yscroll = true
	elif tile_id == TileData.SPECIAL_TILE_PORTAL_SHIP:
		PlayerData.vehicle_transform (self, "Ship")
		PlayerData.calc_ground_y (pos, 10)
		PlayerData.yscroll = false
