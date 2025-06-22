extends MeshInstance3D
var entrances = []
var stage=1
@onready var node_3d: Node3D = $"../.."
func _process(delta: float) -> void:
	if(entrances.size() == 6 and stage==1):
		node_3d.stage=2
		stage=2


func _on_area_3d_area_entered(area: Area3D) -> void:
	if(area.name not in entrances and stage==1):
		entrances.append(area.name)
		if(area.get_node("CollisionShape3D").get_node("indicator")):	
			area.get_node("CollisionShape3D").get_node("indicator").queue_free()
