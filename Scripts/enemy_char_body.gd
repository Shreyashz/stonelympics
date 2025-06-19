extends CharacterBody3D

var player = null

@export var speed = 4.0

@export var player_path: NodePath
@export var agent_nav: NavigationAgent3D

func _ready() -> void:
	player = get_node(player_path)
func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	#Navigation
	agent_nav.set_target_position(player.global_transform.origin)
	var next_nav_point = agent_nav.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	look_at(Vector3(player.global_transform.origin.x, global_position.y, player.global_transform.origin.z), Vector3.UP)
	move_and_slide()
