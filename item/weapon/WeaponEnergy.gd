extends Node

var energy = 0.0
var energy_max = 100.0
var recharge = 1.0
#enum {ALWAYS, EMPTY}
#var recharge_mode = ALWAYS

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if energy < energy_max:
		energy += recharge * delta
		if energy > energy_max:
			energy = energy_max
	pass
	
