extends Area

var timer : float = 5.0
var speed : float = 50.0
var ignore_list : Array = []

func _physics_process(delta):
	if delta == 0:
		return
		
	var s = speed * delta
	translate(Vector3(0, -s, 0 ))
		
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
	
	if target.has_method("take_damage"):
		var dict = {
			"damage": 100
		}
		target.take_damage(dict)
		pass
	
	queue_free()	
	
	pass




func _on_RockfallProjectile_area_entered(area):
	hit(area)
	pass # Replace with function body.


func _on_RockfallProjectile_body_entered(body):
	hit(body)
	pass # Replace with function body.
