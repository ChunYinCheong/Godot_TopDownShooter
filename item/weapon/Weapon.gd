extends "res://item/Item.gd"

var holding_attack : bool = false
var holding_special : bool = false
var holding_melee : bool = false
	
func attack_pressed():
	holding_attack = true
	pass
	
func attack_released():
	holding_attack = false
	pass
	
func special_pressed():
	holding_special = true
	pass
	
	
func special_released():
	holding_special = false
	pass
	
func melee_pressed():
	holding_melee = true
	return
	
func melee_released():
	holding_melee = false
	return
	
func release_all():
	if holding_attack:
		attack_released()
	if holding_special:
		special_released()
	if holding_melee:
		melee_released()
	pass
	
func _on_InteractiveArea_interact(unit):
	pickup()
	unit.interact_weapon(self)
	pass # Replace with function body.
	

func drop():
	release_all()
	.drop()