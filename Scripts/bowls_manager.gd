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
	var instance = bowl_scene.instantiate()
	instance.position = Vector3(-2,1,-0.1)
	add_child(instance)
