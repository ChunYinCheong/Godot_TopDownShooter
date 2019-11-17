extends KinematicBody

signal die

export var team : int = 1
export var movement_speed : float = 10
export var base_movement_speed : float = 10



var status_effect : Array = []


func _process(delta):
	var temp = status_effect.duplicate(false)
	var need_update = false
	for se in status_effect:
		if se.time_left > delta:
			se.time_left -= delta
			se.process(delta)
		else:
			se.process(se.time_left)
			temp.erase(se)
			need_update = true
	status_effect = temp
	if need_update:
		update_statistic()
	pass
	
func add_status_effect(se):
	status_effect.append(se)
	update_statistic()
	pass
	
func update_statistic():
	reset_statistic()
	for se in status_effect:
		se.update_statistic(self)	
	pass
	
func reset_statistic():
	movement_speed = base_movement_speed
	pass
	
func die():
	emit_signal("die")
	
	queue_free()
	pass
