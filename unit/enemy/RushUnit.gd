extends "res://unit/Unit.gd"

var cooldown : float = 1
var players : Array = []

var rush_left : float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	players = get_tree().get_nodes_in_group("Player")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not players.empty() and rush_left < 0:
		var target = players[0].global_transform.origin
		target.y = self.global_transform.origin.y
		look_at(target, Vector3(0,1,0))
	if cooldown <= 0:
		rush_left = 0.5
		$Area.monitoring = true
#		attack()
		cooldown = 1
		pass
	else:
		cooldown = cooldown - delta
	pass


func _physics_process(delta):
	var facing = -self.global_transform.basis.z
	var move_vector = Vector3() 
	if rush_left > 0:
		move_vector = facing.normalized() * 5 * movement_speed
		rush_left -= delta
		if rush_left < 0:
			$Area.monitoring = false		
			
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
	pass



func _on_DestructibleArea_die():
	die()
	pass # Replace with function body.


func _on_Area_area_entered(area):
	hit(area)
	pass # Replace with function body.


func _on_Area_body_entered(body):
	hit(body)
	pass # Replace with function body.

func hit(target):
	if target == self:
		return
	if target == $DestructibleArea:
		return
	var particles = preload("res://item/weapon/BulletHitEffect.tscn").instance()
#		particles.global_translate(body.global_transform.origin)
	particles.set_global_transform(target.global_transform)
	get_tree().current_scene.add_child(particles)
	
	if target.has_method("take_damage"):
		var dict = {
			"damage": 100
		}				
		target.take_damage(dict)
	
