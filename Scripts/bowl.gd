extends RigidBody3D
var has_berry = true
func _ready() -> void:
	gravity_scale = 0.0

func _physics_process(delta: float) -> void:
	linear_velocity = Vector3(1, 0, 0)  # Se moverá en X con velocidad 10
