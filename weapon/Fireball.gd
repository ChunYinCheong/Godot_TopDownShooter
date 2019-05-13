extends Area

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer : float = 3.0
var speed : float = 50.0
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
	if ignore_list.has(body):
		return
		
	var particles = preload("res://weapon/HitEffect.tscn").instance()
	particles.global_translate(self.transform.origin)
	get_tree().get_root().add_child(particles)
	
	queue_free()	
	pass # Replace with function body.

func add_ignore(body):
	ignore_list.append(body)
	
	