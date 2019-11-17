extends Area

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer : float = 5.0
var speed : float = 20.0
var ignore_list : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):


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

func _on_Fireball_body_entered(body):
	hit(body)
	pass

func add_ignore(body):
	ignore_list.append(body)
	


func _on_Fireball_area_entered(area):
	hit(area)
	pass
	
	
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


