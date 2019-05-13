extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cooldown : float = 1
var players : Array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	players = get_tree().get_nodes_in_group("player")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not players.empty():
		var target = players[0].global_transform.origin
		target.y = self.global_transform.origin.y
		look_at(target, Vector3(0,1,0))
	cooldown = cooldown - delta
	if cooldown <= 0:
		attack()
		cooldown = 1
	pass


func _physics_process(delta):
	var facing = -self.global_transform.basis.z
	var move_vector = facing.normalized() * 20
	move_vector.y = -100
	move_and_slide(move_vector,Vector3(0, 1, 0))

func attack():
		
	var area = $Area
	var bodies = area.get_overlapping_bodies()

	for body in bodies:
		if body == self:
			continue
		
		var particles = preload("res://weapon/HitEffect.tscn").instance()
		particles.global_translate(body.global_transform.origin)
		get_tree().get_root().add_child(particles)
		
	pass

