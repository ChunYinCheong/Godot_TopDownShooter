extends RigidBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var _mode
var _layer
var _mask

var is_hold : bool = false
var rate : float = 10.0
var cooldown : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cooldown > 0 :
		cooldown = cooldown - delta
	if is_hold:
		fire()
	pass
func pickup():
	_mode = self.mode
	_layer = self.collision_layer
	_mask = self.collision_mask
	
	self.mode = RigidBody.MODE_STATIC
	self.collision_layer = 0
	self.collision_mask = 0
	
	set_process(true)
	
func drop():
	self.mode = _mode
	self.collision_layer = _layer
	self.collision_mask = _mask
	
	
	set_process(false)
	
func fire():
	if cooldown > 0:
		return	
	cooldown = 1.0 / rate
	
	var pos = $Position3D
	var bullet = preload("res://weapon/BulletEffect.tscn").instance()
	#bullet.global_translate(pos.global_transform.origin)
	bullet.global_transform = pos.global_transform
	
	var ray = $RayCast
	ray.force_raycast_update()
	if ray.is_colliding():
		var particles = preload("res://weapon/HitEffect.tscn").instance()
		particles.global_translate(ray.get_collision_point())
		get_tree().get_root().add_child(particles)
		
		
		bullet.destination = ray.get_collision_point()
		get_tree().get_root().add_child(bullet)
	else:
		get_tree().get_root().add_child(bullet)
	

#		var body = ray.get_collider()
#		elif body.has_method("bullet_hit"):
#			body.bullet_hit(DAMAGE, ray.global_transform)

func fire_pressed():
	fire()
	is_hold = true
	pass
	
	
func fire_released():
	is_hold = false
	pass
	