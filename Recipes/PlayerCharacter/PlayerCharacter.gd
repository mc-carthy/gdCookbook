extends KinematicBody

onready var head_pivot: Spatial = $HeadPivot

var move_speed: float = 10.0
var direction: Vector3 = Vector3()
var velocity: Vector3 = Vector3()
var mouse_sensitivity: float = 0.3

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head_pivot.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))

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
