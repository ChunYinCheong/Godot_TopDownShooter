extends Area

var timer : float = 5.0
var speed : float = 25.0
var ignore_list : Array = []

func _physics_process(delta):
	if delta == 0:
		return
		
	var s = speed * delta
	translate(Vector3(0, 0, -s ))
		
	timer = timer - delta
	if timer <= 0:
#		print("timer free")
		queue_free()
		return
				
	pass

func add_ignore(body):
	ignore_list.append(body)
		
func hit(target):
	if ignore_list.has(target):
		return
		
	var particles = preload("res://item/weapon/BulletHitEffect.tscn").instance()
#	particles.global_translate(self.transform.origin)
	particles.set_global_transform(self.global_transform)
	get_tree().current_scene.add_child(particles)
	
	if target.has_method("add_status_effect"):
		var se = preload("res://status_effect/Shock.gd").new()
		target.add_status_effect(se)
		pass
	
	queue_free()
	pass

func _on_ShockTrap_area_entered(area):
	hit(area)
	pass # Replace with function body.

func _on_ShockTrap_body_entered(body):
	hit(body)
	pass # Replace with function body.
