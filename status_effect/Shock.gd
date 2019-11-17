extends "res://status_effect/StatusEffect.gd"

func _init():
	duration = 0.5
	time_left = 0.5

func update_statistic(unit):
	unit.movement_speed = 0.0