extends Node3D
@onready var node_3d: Node3D = $"../.."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if(body is RigidBody3D):
		if(!node_3d.grabbed):
			print("GRABBED A BERRY!")
			node_3d.grabbed=true
	
	if(body is StaticBody3D):
		node_3d.store()
		node_3d.grabbed=false
