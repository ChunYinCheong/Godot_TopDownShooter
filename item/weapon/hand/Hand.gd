extends "res://item/weapon/Weapon.gd"

var energy : float = 0.0

func _process(delta):
	if holding_attack:
		energy += delta
		$Particles.process_material.initial_velocity = 1 + energy
#		$Particles.amount = 8
	pass
	
	
func fire():
	var pos = $Position3D
	var fireball = preload("res://skill/spell/Fireball.tscn").instance()
	fireball.add_ignore(self)
	fireball.global_transform = pos.global_transform
	
	get_tree().current_scene.add_child(fireball)	
	pass

func attack_pressed():
	.attack_pressed()
	if $Channeling.channeling:
		$Channeling.begin_casting()
	else:
		energy = 0
		$Particles.process_material.initial_velocity = 0
		$Particles.emitting = true	

func attack_released():
	.attack_released()
	if $Channeling.channeling:
		$Channeling.stop_casting()
	else:
		fire()
		$Particles.emitting = false	
	pass
	
func special_pressed():
	.special_pressed()
	$Channeling.begin_channeling()
	pass
	
	
func special_released():
	.special_released()
	$Channeling.stop_channeling()
	pass
