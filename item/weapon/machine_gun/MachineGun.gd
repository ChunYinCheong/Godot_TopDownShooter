extends "res://item/weapon/Weapon.gd"

onready var primary_energy = $WeaponEnergy
onready var primary_cooldown = $WeaponCooldown
var primary_energy_consumption = 1.0

func _ready():
	primary_energy.energy_max = 1000.0
	primary_energy.recharge = 5.0
	primary_cooldown.fire_rate = 50.0
	pass

func _process(delta):
	if holding_attack:
		fire()
	pass
	
func attack_pressed():
	.attack_pressed()
	fire()
	pass
	
func fire():	
	if primary_cooldown.cooldown > 0:
		return
	if primary_energy.energy < primary_energy_consumption:
		return
	primary_cooldown.start()
	primary_energy.energy -= primary_energy_consumption
	
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

func create_control():
	var control = preload("res://item/weapon/machine_gun/MachineGunControl.tscn").instance()
	control.item = self
	return control