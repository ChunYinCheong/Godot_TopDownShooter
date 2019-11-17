extends Node

var fire_rate = 10.0
var cooldown = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cooldown > 0:
		cooldown -= delta
	pass
	
	
func start():
	cooldown = 1.0 / fire_rate
	pass