extends Node3D

@onready var camera_3d: Camera3D = $Camera3D
@onready var mano: Node3D = $Camera3D/Untitled

var grabbed = false
var cont = 0
var body
var stage=1
var contLeft=0
var contRight=0
var BERRIES := 0
var limitL = 0
var limitR = 0
var ableLeft = true
var ableRight = true
var struggle_mouse_pos
func _ready() -> void:
	camera_3d.make_current()
func _process(delta: float) -> void:
	if(Input.is_action_pressed("primary_fire")):
		move_hand()
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(mano, "position", Vector3(0.005, -0.227, -0.183), 0.1)
		mano.rotation = Vector3(0,deg_to_rad(180),0)
	
	if(stage==2):
		print("contleft: ", contLeft)
		print("contRight: ", contRight)
		if(get_viewport().get_mouse_position().x < 483 and ableLeft):
			contLeft+=1
			ableLeft = false
			ableRight = true
		if(get_viewport().get_mouse_position().x > 692 and ableRight):
			contRight+=1
			ableRight=false
			ableLeft = true
		
		if(contLeft == 10 and contRight == 10):
			print("YOU DID IT!!!!!!")
			stage=10
		
func move_hand() -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	mouse_pos.y = mouse_pos.y
	var from = camera_3d.project_ray_origin(mouse_pos)
	var to = from + camera_3d.project_ray_normal(mouse_pos) * 300
	var query = PhysicsRayQueryParameters3D.new()
	query.from = from
	query.to = to
	query.collision_mask = 1

	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(query)
	if result:
		var tween = get_tree().create_tween()
		tween.tween_property(mano, "global_position", result.position + Vector3(0,0,0.05), 0.1)
		mano.look_at(result.position + result.normal, Vector3.UP)
