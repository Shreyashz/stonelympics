extends Node3D

@onready var camera_3d: Camera3D = $Camera3D
@onready var mano: Node3D = $Camera3D/Untitled
var grabbed = false
var cont = 0
var body
var limitL = 0
var limitR = 0
var ableLeft = true
var ableRight = true
var struggle_mouse_pos
func _ready() -> void:
	camera_3d.make_current()
func _process(delta: float) -> void:
	if(grabbed):
		if(not body.grabbed):
			grabbed=false
			mano.global_position = Vector3(-0.045725, 1.127687, 1.355718)
		if(limitL == 15 && limitR == 15):
			grabbed = false
			if(body):
				body.grabbed=false
		if(cont==0):
			struggle_mouse_pos = get_viewport().get_mouse_position()
			cont+=1
		if(get_viewport().get_mouse_position().x > struggle_mouse_pos.x +99 && ableRight):
			ableLeft = true
			ableRight = false
			limitR+=1
		if(get_viewport().get_mouse_position().x < struggle_mouse_pos.x -99 && ableLeft):
			ableLeft = false
			ableRight = true
			limitL+=1
	if(Input.is_action_pressed("primary_fire") && not grabbed):
		move_hand()
	if(Input.is_action_just_released("primary_fire") && not grabbed):
		mano.global_position = Vector3(-0.045725, 1.127687, 1.355718)
		
func move_hand() -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	mouse_pos.y = mouse_pos.y + 40
	var from = camera_3d.project_ray_origin(mouse_pos)
	var to = from + camera_3d.project_ray_normal(mouse_pos) * 300.0

	var query = PhysicsRayQueryParameters3D.new()
	query.from = from
	query.to = to
	query.collision_mask = 1  # Ajusta según tus capas

	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(query)

	if result:
		mano.global_transform.origin = result.position + Vector3(0,0.05,0)
		mano.look_at(result.position + result.normal, Vector3.UP)
