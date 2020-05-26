extends Camera

const RAY_LENGTH = 1000

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var from: Vector3 = project_ray_origin(event.position)
		var to: Vector3 = from + project_ray_normal(event.position) * RAY_LENGTH
		var space_state: PhysicsDirectSpaceState = get_world().direct_space_state
		var result = space_state.intersect_ray(from, to, [], 1)
		if result:
			get_tree().call_group('units', 'move_to', result.position)
