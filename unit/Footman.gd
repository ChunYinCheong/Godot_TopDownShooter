extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	weapon = $Handgun
	weapon.pickup()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var h = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var v = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	var move_vector = Vector3(h,0,v).normalized() * 70
	move_vector.y = -100
	move_and_slide(move_vector,Vector3(0, 1, 0))
	
	var aim_vector : Vector2 = Vector2()
	aim_vector.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
	aim_vector.y = Input.get_action_strength("aim_up") - Input.get_action_strength("aim_down")
	if aim_vector.length() > 0 :
		self.rotation.y =  aim_vector.angle() - PI/2
#		print("aim_vector: ", aim_vector)
#		print("angle: ", aim_vector.angle())
#		print("rotation: " , rotation)
#		print("rotation_degrees: " , rotation_degrees)

	if Input.get_action_strength("aim_mouse") > 0:
		var ray_length = 1000
		var camera = get_viewport().get_camera()
		var from = camera.project_ray_origin(get_viewport().get_mouse_position())
		var to = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * ray_length
		var hit = get_world().get_direct_space_state().intersect_ray(from, to)
		if hit.size() != 0:
			# collider will be the node you hit
			var p = hit.position
			p.y = self.translation.y
			look_at(p,Vector3(0,1,0))
			
			
	pass
	
func _unhandled_input(event):
	if event.is_action_pressed("fire"):
		if weapon:
			weapon.fire_pressed()
		return
	if event.is_action_released("fire"):
		if weapon:
			weapon.fire_released()
		return
	
	pass