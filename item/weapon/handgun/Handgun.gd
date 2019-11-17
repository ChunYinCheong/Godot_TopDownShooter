extends "res://item/weapon/Weapon.gd"

signal ammo_changed (ammo)

onready var primary_cooldown = $WeaponCooldown
var ammo = 10
var ammo_max = 10
var reloading = false
var reload_time = 1.0
var reload_countdown = 1.0

func _ready():
	primary_cooldown.fire_rate = 5.0
	pass

func _process(delta):
	if reloading:
		reload_countdown -= delta
		if reload_countdown <= 0:
			reloading = false
			ammo = ammo_max
			emit_signal("ammo_changed",ammo)
	pass
	
func attack_pressed():
	.attack_pressed()
	fire()
	pass
	
func fire():
	if reloading:
		return
	if primary_cooldown.cooldown > 0:
		return
	if ammo < 1:
		return
	primary_cooldown.start()
	ammo -= 1
	emit_signal("ammo_changed",ammo)
	
	var pos = $Position3D
	var bullet = preload("res://item/weapon/BulletEffect.tscn").instance()
	#bullet.global_translate(pos.global_transform.origin)
	bullet.global_transform = pos.global_transform
	
	var ray : RayCast  = $RayCast
	ray.force_raycast_update()
	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider.has_method("take_damage"):
			var dict = {
				"damage": 100,
				"shape_id": ray.get_collider_shape(),
				"collision_normal": ray.get_collision_normal(),
				"collision_point": ray.get_collision_point()
			}
			collider.take_damage(dict)
			pass
		
		
		var particles = preload("res://item/weapon/BulletHitEffect.tscn").instance()
		particles.global_translate(ray.get_collision_point())
		get_tree().current_scene.add_child(particles)
		
		bullet.destination = ray.get_collision_point()
	get_tree().current_scene.add_child(bullet)	
	pass

func special_pressed():
	if reloading:
		return	
	reloading = true
	reload_countdown = reload_time
	
func release_all():
	.release_all()
	reloading = false	
	
func create_control():
	var control = preload("res://item/weapon/handgun/HandgunControl.tscn").instance()
	control.item = self
	return control