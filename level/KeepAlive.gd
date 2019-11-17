extends Spatial

# var b = "text"
onready var camera = $Camera
onready var footman = $Unit/FootmanUnit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_instance_valid(footman):
		camera.global_transform.origin.x = footman.global_transform.origin.x
		camera.global_transform.origin.z = footman.global_transform.origin.z
#	camera.look_at(footman.global_transform.origin, Vector3(0,1,0))
	pass


func _on_Timer_timeout():
	print("You Win!")
	var enemy_list = get_tree().get_nodes_in_group("Enemy")
	for enemy in enemy_list:
		enemy.queue_free()
	pass # Replace with function body.
