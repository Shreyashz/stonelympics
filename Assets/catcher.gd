extends Node3D

var randomizer = RandomNumberGenerator.new()
var watching = false
@onready var node_3d: Node3D = $"../.."
var duration
var timer = 0.0
var watch_timer = 0.0

func _process(delta: float) -> void:
	timer += delta
	if timer >= 1.5 && !watching:
		randomizer.randomize()
		var n = randomizer.randi_range(1, 3)
		if n == 1:
			randomizer.randomize()
			duration = randomizer.randi_range(3, 6)
			timer = 0
			var tween = get_tree().create_tween()
			tween.tween_method(_set_rotation_y, rotation.y, deg_to_rad(-35), 0.4)
			watching = true
		else:
			timer = 0

	if watching:
		watch_timer += delta
		if watch_timer > duration / 2 and node_3d.grabbed:
			print("GAMEOVER")
		if watch_timer > duration:
			var tween = get_tree().create_tween()
			tween.tween_method(_set_rotation_y, rotation.y, deg_to_rad(145), 0.4)
			watch_timer = 0
			watching = false

func _set_rotation_y(value):
	rotation.y = value
