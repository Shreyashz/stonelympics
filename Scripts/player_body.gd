extends CharacterBody3D
@export_category("Camera and Player Controls")
@export var MOUSE_SENSITIVITY :float = 0.5
@export var tilt_upper_limit := deg_to_rad(85)
@export var tilt_lower_limit := deg_to_rad(-85)
@export var CAMERA_CONTROLLER :Camera3D
@export_category("Hands Control")
@export var hand_animation_player: AnimationPlayer
@export var raycast: RayCast3D
@export var palm: Node3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var mouse_input: bool = false
var mouse_rotation: Vector3
var rotation_input: float
var tilt_input: float
var player_rotation:Vector3
var camera_rotation: Vector3

var pickupObj

func _input(event):
	if event.is_action_pressed("escape"):
		get_tree().quit()

func _unhandled_input(event: InputEvent) -> void:
	mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if mouse_input:
		rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		tilt_input = -event.relative.y * MOUSE_SENSITIVITY

func _update_camera(delta):
	mouse_rotation.x += tilt_input*delta
	mouse_rotation.x = clamp(mouse_rotation.x, tilt_lower_limit, tilt_upper_limit)
	mouse_rotation.y += rotation_input * delta
	
	player_rotation = Vector3(0.0, mouse_rotation.y, 0.0)
	camera_rotation = Vector3(mouse_rotation.x, 0.0, 0.0)
	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(camera_rotation)
	CAMERA_CONTROLLER.rotation.z = 0
	global_transform.basis = Basis.from_euler(player_rotation)
	
	rotation_input = 0.00
	tilt_input = 0.0


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	pickupObj = raycast.get_collider()
	if raycast.is_colliding():
		if pickupObj.is_in_group("pickable"):
			if Input.is_action_pressed("primary_fire"):
				pickupObj.global_position = palm.global_position
				pickupObj.global_rotation = palm.global_rotation
				pickupObj.collision_layer = 2
				pickupObj.linear_velocity = Vector3(0.1, 3.0, 0.1)
			if Input.is_action_just_pressed("primary_fire"):
				hand_animation_player.play("grab")
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	_update_camera(delta)
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():	
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
