extends Control

const WeaponSystem = preload("res://unit/player/WeaponSystem.gd")


onready var sidearm = $HBoxContainer/Sidearm
onready var primary = $HBoxContainer/Primary
onready var weapon2 = $HBoxContainer/Weapon2
onready var weapon3 = $HBoxContainer/Weapon3


func _on_WeaponSystem_weapon_changed(ws : WeaponSystem):
	for c in sidearm.get_children():
		c.queue_free()
	sidearm.add_child(ws.sidearm.create_control())
	for c in primary.get_children():
		c.queue_free()
	primary.add_child(ws.primary.create_control())
	
	for c in weapon2.get_children():
		c.queue_free()
	for c in weapon3.get_children():
		c.queue_free()
	
	weapon2.add_child(ws.weapon2.create_control())
	weapon3.add_child(ws.weapon3.create_control())
	pass

