extends KinematicBody2D
class_name Vehicle

var velocity: = Vector2.ZERO

onready var spr_a: = $SprA
onready var spr_b: = $SprB
onready var floor_particles: = $FloorParticles
onready var _trail: = $Trail

var angle: = 0.0
var trail: = false setget set_trail

var maxvsp: = 5000

func _ready () -> void:
	spr_a.modulate = PlayerData.color_a
	spr_b.modulate = PlayerData.color_b
	floor_particles.modulate = PlayerData.color_b
	
	_trail.default_color = PlayerData.color_b
	_trail.default_color.a = 0.25
	_trail.is_emitting = false

func _physics_process (delta: float) -> void:
	if is_on_wall ():# or is_on_ceiling():
		die ()
	
	move_vehicle (delta)
	
	floor_particles.emitting = is_on_floor ()
	
	# TODO: This might give errors in the ship
	if Input.is_action_just_pressed ("jump") and not is_on_floor ():
		PlayerData.canring = true
	
	if PlayerData.canring and is_on_floor ():
		PlayerData.canring = false

func move_vehicle (delta: float) -> void:
	velocity.x = PlayerData.speed.x * PlayerData.speed_boost
	velocity.y = clamp (velocity.y + ((PlayerData.grav * delta) * PlayerData.gravdir), -maxvsp, maxvsp)

func die () -> void:
	# TODO: Die
	# queue_free ()
	get_tree ().paused = true

func set_trail (trail_val: bool) -> void:
	trail = trail_val
	_trail.is_emitting = trail_val

func handle_special (tile_id: int, pos: Vector2) -> void:
	if tile_id == TileData.SPECIAL_TILE_RING_YELLOW and PlayerData.canring:
		velocity.y = -PlayerData.speed.y * PlayerData.gravdir
		PlayerData.canring = false
		self.trail = true
	elif tile_id == TileData.SPECIAL_TILE_RING_PINK and PlayerData.canring:
		velocity.y = - (PlayerData.speed.y - (PlayerData.speed.y * 0.1)) * PlayerData.gravdir
		PlayerData.canring = false
		self.trail = true
	elif tile_id == TileData.SPECIAL_TILE_RING_BLUE and PlayerData.canring:
		PlayerData.gravdir *= -1
		velocity.y = PlayerData.speed.y * PlayerData.gravdir
		PlayerData.canring = false
		self.trail = true
	elif tile_id == TileData.SPECIAL_TILE_RING_ORANGE and PlayerData.canring:
		velocity.y = -(PlayerData.speed.y + (PlayerData.speed.y * 0.2)) * PlayerData.gravdir
		PlayerData.canring = false
		self.trail = true
	elif tile_id == TileData.SPECIAL_TILE_RING_GREEN and PlayerData.canring:
		PlayerData.gravdir *= -1
		velocity.y = -PlayerData.speed.y * PlayerData.gravdir
		PlayerData.canring = false
		self.trail = true
	
	elif tile_id == TileData.SPECIAL_TILE_DASH_GREEN and PlayerData.canring:
		# TODO: Dash
		PlayerData.canring = false
	elif tile_id == TileData.SPECIAL_TILE_DASH_PINK and PlayerData.canring:
		# TODO: Dash
		PlayerData.canring = false
	
	elif tile_id == TileData.SPECIAL_TILE_BUMP_YELLOW:
		velocity.y = -(PlayerData.speed.y * 1.35) * PlayerData.gravdir
		self.trail = true
	elif tile_id == TileData.SPECIAL_TILE_BUMP_PINK:
		velocity.y = -(PlayerData.speed.y - (PlayerData.speed.y * 0.1)) * PlayerData.gravdir
		self.trail = true
	elif tile_id == TileData.SPECIAL_TILE_BUMP_BLUE:
		PlayerData.gravdir *= -1
		self.trail = true
		velocity.y = PlayerData.speed.y * PlayerData.gravdir
	elif tile_id == TileData.SPECIAL_TILE_BUMP_ORANGE:
		velocity.y = -(PlayerData.speed.y + (PlayerData.speed.y * 0.8)) * PlayerData.gravdir
		self.trail = true
	
	# TODO: Portals
	elif tile_id == TileData.SPECIAL_TILE_PORTAL_CUBE:
		PlayerData.vehicle_transform (self, "Cube")
		PlayerData.reset_g2y ()
		PlayerData.yscroll = true
	elif tile_id == TileData.SPECIAL_TILE_PORTAL_SHIP:
		PlayerData.vehicle_transform (self, "Ship")
		PlayerData.calc_ground_y (pos, 10)
		PlayerData.yscroll = false
