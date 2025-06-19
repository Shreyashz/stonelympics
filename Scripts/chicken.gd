extends CharacterBody3D

var grabbed=false
var time := 0.0
var cooldown :=0.0
var grabbable=true
var dir:=Vector3.ZERO
var speed = -1
var struggle_speed = -10
# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	if(!grabbed):
		dir =-transform.basis.z
		if(is_on_floor() == false):
			velocity.y -=9.8*delta
		else:
			velocity = speed * dir
			var flat_dir = dir
			flat_dir.y=0
			look_at(transform.origin + flat_dir.normalized(), Vector3.UP)
	else:
		time+=delta
		dir =-transform.basis.z
		velocity = dir * struggle_speed
		if(time>=4):
			grabbed=false
			cooldown=1
	move_and_slide()
	struggle_speed = struggle_speed *-1
	var flat_dir = dir
	flat_dir.y=0
	if(cooldown>0):
		grabbable=false
		cooldown-=delta
	else:
		grabbable=true
