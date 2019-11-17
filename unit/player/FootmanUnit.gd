extends "res://unit/Unit.gd"

const Weapon = preload("res://item/weapon/Weapon.gd")

signal begin_channeling_element
signal stop_channeling_element

onready var weapon_system = $WeaponSystem

func _init():
	base_movement_speed = 12.5
	movement_speed = 12.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var h = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var v = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	var move_vector = Vector3(h,0,v).normalized() * movement_speed
	move_vector.y = -9.8
	move_and_slide(move_vector,Vector3(0, 1, 0))
	
	var aim_vector : Vector2 = Vector2()
	aim_vector.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
	aim_vector.y = Input.get_action_strength("aim_up") - Input.get_action_strength("aim_down")
	if aim_vector.length() > 0 :
		print("aim: ",aim_vector, " length: ",aim_vector.length()," angle: ", aim_vector.angle())
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
	if weapon_system.is_channeling():
		if event.is_action_pressed("fire_element"):
			emit_signal("begin_channeling_element","fire")
			return
		elif event.is_action_pressed("air_element"):
			emit_signal("begin_channeling_element","air")
			return
		elif event.is_action_pressed("water_element"):
			emit_signal("begin_channeling_element","water")
			return
		elif event.is_action_pressed("earth_element"):
			emit_signal("begin_channeling_element","earth")
			return
		elif event.is_action_released("fire_element"):
			emit_signal("stop_channeling_element","fire")
			return
		elif event.is_action_released("air_element"):
			emit_signal("stop_channeling_element","air")
			return
		elif event.is_action_released("water_element"):
			emit_signal("stop_channeling_element","water")
			return
		elif event.is_action_released("earth_element"):
			emit_signal("stop_channeling_element","earth")
			return
		elif event.is_action_pressed("alchemy_up"):
			emit_signal("begin_channeling_element","up")
			return
		elif event.is_action_pressed("alchemy_down"):
			emit_signal("begin_channeling_element","down")
			return
		elif event.is_action_pressed("alchemy_left"):
			emit_signal("begin_channeling_element","left")
			return
		elif event.is_action_pressed("alchemy_right"):
			emit_signal("begin_channeling_element","right")
			return
		elif event.is_action_released("alchemy_up"):
			emit_signal("stop_channeling_element","up")
			return
		elif event.is_action_released("alchemy_down"):
			emit_signal("stop_channeling_element","down")
			return
		elif event.is_action_released("alchemy_left"):
			emit_signal("stop_channeling_element","left")
			return
		elif event.is_action_released("alchemy_right"):
			emit_signal("stop_channeling_element","right")
			return
		pass
	
	if (event.is_action("primary_attack")
		or event.is_action("primary_special")
		or event.is_action("sidearm_attack")
		or event.is_action("sidearm_special")
		or event.is_action("melee")
		or event.is_action("switch_weapons")
	):
		weapon_system.handle_input(event)
		return
		
	if event.is_action_pressed("interact"):
		interact()
		return
		
	
func interact():
	var focus = $InteractArea.current_focus
	if focus:
		focus.interact(self)
	pass
	
func interact_weapon(w :Weapon):
	weapon_system.interact_weapon(w)
	pass


func _on_DestructibleArea_die():
	die()
	pass # Replace with function body.

