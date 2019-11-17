extends "res://unit/Unit.gd"


var cooldown : float = 1
var players : Array = []

var casting_spell

# Called when the node enters the scene tree for the first time.
func _ready():
	players = get_tree().get_nodes_in_group("Player")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cooldown > 0:
		cooldown = cooldown - delta
	if not players.empty():
		var target = players[0].global_transform.origin
		target.y = self.global_transform.origin.y
		look_at(target, Vector3(0,1,0))
		if cooldown <= 0 and not casting_spell:
			if self.global_transform.origin.distance_to(target) < 200:
				attack()
			else:
				attack2(target)
#			cooldown = 1
	pass

func attack():
	var pos = $Position3D
	var fireball = preload("res://skill/spell/Fireball.tscn").instance()
	fireball.global_transform = pos.global_transform
	fireball.add_ignore(self)
	fireball.add_ignore($DestructibleArea)
	
	get_tree().current_scene.add_child(fireball)	
	cooldown = 1
	pass
	
func attack2(target):
	var spell = preload("res://skill/spell/Rockfall.tscn").instance()
	spell.global_transform = self.global_transform
	add_child(spell)
	casting_spell = spell
	spell.connect("finish_casting",self,"on_spell_finish_casting")
	spell.begin_channeling()
	spell.begin_casting(target)
	#get_tree().current_scene.add_child(fireball)	
	cooldown = 2
	pass
	
func on_spell_finish_casting():
	casting_spell.stop_casting()
	casting_spell.stop_channeling()
	casting_spell = null

func _physics_process(delta):
	var move_vector = Vector3(0,-100,0)
	move_and_slide(move_vector,Vector3(0, 1, 0))

func _on_DestructibleArea_die():
	die()
	pass # Replace with function body.

