extends "res://skill/spell/ISpell.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init():
	spell_name = "Rockfall"
	activating_movement_speed_adjust = 1.0
	activating_turning_speed_adjust = 1.0
	mp = 0	
	pass

func _start_effect():
	var projectile = preload("res://skill/spell/RockfallProjectile.tscn").instance()
	var p = target_position
	p.y += 50
	projectile.global_transform.origin = p
	get_tree().current_scene.add_child(projectile)
	var mark = preload("res://skill/spell/RockfallMark.tscn").instance()
	mark.global_translate(target_position)
	get_tree().current_scene.add_child(mark)
	pass
