extends "res://unit/Unit.gd"

var cooldown : float = 1
var players : Array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	players = get_tree().get_nodes_in_group("Player")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not players.empty():
		var target = players[0].global_transform.origin
		target.y = self.global_transform.origin.y
		look_at(target, Vector3(0,1,0))
	if cooldown <= 0:
		attack()
		cooldown = 1
	else:
		cooldown = cooldown - delta
	pass


func _physics_process(delta):
	var facing = -self.global_transform.basis.z
	var move_vector = facing.normalized() * movement_speed
	move_vector.y = -100
	move_and_slide(move_vector,Vector3(0, 1, 0))

func attack():
		
	var area = $Area
	var bodies = area.get_overlapping_areas()
	

	for body in bodies:
		if body == self:
			continue
		if body == $DestructibleArea:
			continue
		
		var particles = preload("res://item/weapon/BulletHitEffect.tscn").instance()
#		particles.global_translate(body.global_transform.origin)
		particles.set_global_transform(body.global_transform)
		get_tree().current_scene.add_child(particles)
		
		if body.has_method("take_damage"):
			var dict = {
				"damage": 100
			}				
			body.take_damage(dict)
	pass



func _on_DestructibleArea_die():
	die()
	pass # Replace with function body.
