extends CharacterBody3D

var player = null
var Target: Vector3
var direction: Vector3

@export var speed:float = 4.0
@export var escape_distance: float = 10.0

@export var player_path: NodePath
@export var agent_nav: NavigationAgent3D


func _ready() -> void:
	player = get_node(player_path)

func _time_to_flee() -> void:
	var playerPos = player.global_transform.origin
	direction = global_transform.origin.direction_to(playerPos)
	var cTarget = global_transform.origin - direction * escape_distance
	cTarget.y = global_transform.origin.y
	Target = cTarget

func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	#Navigation
	_time_to_flee()
	agent_nav.set_target_position(Target)
	var next_nav_point = agent_nav.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	look_at(Target, Vector3.UP)
	move_and_slide()
