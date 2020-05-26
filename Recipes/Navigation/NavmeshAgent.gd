extends KinematicBody

const move_speed: float = 5.0

onready var navmesh = get_parent() as Navigation

var path = []
var path_index: int = 0

func _ready() -> void:
	add_to_group('units')

func _physics_process(delta: float) -> void:
	if path_index < path.size():
		var move_vector: Vector3 = path[path_index] - global_transform.origin
		if move_vector.length() < 0.1:
			path_index += 1
		else:
			move_and_slide(move_vector.normalized() * move_speed, Vector3.UP)

func move_to(target: Vector3) -> void:

	path = navmesh.get_simple_path(global_transform.origin, target)
	path_index = 0
