extends "res://skill/alchemy/IAlchemy.gd"


func _start_effect():
	var gun = preload("res://item/weapon/handgun/Handgun.tscn").instance()
	gun.global_transform = self.global_transform
	get_tree().current_scene.add_child(gun)
	pass