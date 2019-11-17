extends "res://unit/Unit.gd"


var cooldown : float = 1
var players : Array = []
var should_move : bool = false

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
		if self.global_transform.origin.distance_to(target) > 10:
			should_move = true
		else: 
			should_move = false
	else:
		should_move = false
	cooldown = cooldown - delta
	if cooldown <= 0:
		attack()
		cooldown = 1
	pass
	
func _physics_process(delta):
	if should_move:
		var facing = -self.global_transform.basis.z
		var move_vector = facing.normalized() * movement_speed
		move_vector.y = -100
		move_and_slide(move_vector,Vector3(0, 1, 0))
	else:
		var move_vector = Vector3(0,-100,0)
		move_and_slide(move_vector,Vector3(0, 1, 0))
		

func attack():
	var pos = $Position3D
	var fireball = preload("res://skill/spell/ShockTrap.tscn").instance()
	fireball.global_transform = pos.global_transform
	fireball.add_ignore(self)
	fireball.add_ignore($DestructibleArea)
	
	get_tree().current_scene.add_child(fireball)	
	pass

func _on_DestructibleArea_die():
	die()
	pass # Replace with function body.
