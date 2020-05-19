extends KinematicBody

var move_speed: float = 10.0
var direction: Vector3 = Vector3()
var velocity: Vector3 = Vector3()

func _process(delta: float) -> void:
	direction = Vector3()
	if Input.is_action_pressed('move_forward'):
		direction += transform.basis.z
	if Input.is_action_pressed('move_backward'):
		direction -= transform.basis.z
	if Input.is_action_pressed('move_left'):
		direction += transform.basis.x
	if Input.is_action_pressed('move_right'):
		direction -= transform.basis.x
	
	direction = direction.normalized()
	velocity = direction * move_speed
	move_and_slide(velocity, Vector3.UP)
