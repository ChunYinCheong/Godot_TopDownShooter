extends Area

signal body_detected(body)

var exclude_list : Array
var mask = (1) + (1 << 4) + (1 << 6)

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	if bodies.size() > 0:
		var form = global_transform.origin
		var space_state = get_world().direct_space_state
		for b in bodies:
			var body : PhysicsBody = b
			if not is_facing(body):
				continue
			var to = body.global_transform.origin
			var exclude = exclude_list.duplicate()
			exclude.append(body)
			var result = space_state.intersect_ray(form, to, exclude, mask)
			if result.empty():
				# Nothing between
				emit_signal("body_detected", body)
				print("See!")

func is_facing(body: PhysicsBody):
	var forward = -global_transform.basis.z
	var form = global_transform.origin
	var to = body.global_transform.origin
	var dir = (to - form).normalized()
	if dir.dot(forward) > 0:
		return true
	else:
		return false