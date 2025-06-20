extends Node
var time := 0.0
@onready var bowl_scene = preload("res://prefabs/bowl.tscn")

func _ready() -> void:
	spawn()
	
func _process(delta: float) -> void:
	time += delta
	if(time >= 4):
		spawn()
		time=0
		
		
func spawn() -> void:
	var instance1 = bowl_scene.instantiate()
	instance1.position = Vector3(-2.5,1.05,0)
	add_child(instance1)
	var instance2 = bowl_scene.instantiate()
	instance2.position = Vector3(-3,1.1,-0.15)
	add_child(instance2)
	var instance3 = bowl_scene.instantiate()
	instance3.position = Vector3(-2.5,1.15,-0.3)
	add_child(instance3)
	var instance4 = bowl_scene.instantiate()
	instance4.position = Vector3(-3,1.20,-0.45)
	add_child(instance4)
