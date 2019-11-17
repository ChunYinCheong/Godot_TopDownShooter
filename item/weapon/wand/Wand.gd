extends "res://item/weapon/Weapon.gd"

onready var primary_cooldown = $WeaponCooldown

func _ready():
	primary_cooldown.fire_rate = 2.0
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
	primary_cooldown.start()
	
	var pos = $Position3D
	var fireball = preload("res://skill/spell/Fireball.tscn").instance()
	fireball.add_ignore(self)
	fireball.add_ignore($DestructibleArea)
	fireball.global_transform = pos.global_transform
	
	get_tree().current_scene.add_child(fireball)	
	pass
