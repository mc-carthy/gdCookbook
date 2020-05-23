extends KinematicBody

onready var head_pivot: Spatial = $HeadPivot

const GRAVITY = -9.8

var move_speed: float = 10.0
var direction: Vector3 = Vector3()
var velocity: Vector3 = Vector3()
var jump_speed: float = 5.0
var mouse_sensitivity: float = 0.3
var max_vertical_camera_angle: float = 60

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed('ui_cancel'):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head_pivot.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head_pivot.rotation.x = clamp(head_pivot.rotation.x, -deg2rad(max_vertical_camera_angle), deg2rad(max_vertical_camera_angle))

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
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	
	if is_on_floor():
		velocity.y = 0
		if Input.is_action_pressed('jump'):
			velocity.y = jump_speed
	else:
		velocity.y += GRAVITY * delta

	velocity = move_and_slide(velocity, Vector3.UP)
