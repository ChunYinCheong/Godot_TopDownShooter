extends Spatial


onready var camera = $Camera
onready var footman = $Unit/FootmanUnit

export var remain = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/Label.text = "Remain: " + str(remain)
	var enemy_list = get_tree().get_nodes_in_group("Enemy")
	for enemy in enemy_list:
		enemy.connect("die",self,"_on_Enemy_die")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_instance_valid(footman):
		camera.global_transform.origin.x = footman.global_transform.origin.x
		camera.global_transform.origin.z = footman.global_transform.origin.z
#	camera.look_at(footman.global_transform.origin, Vector3(0,1,0))
	pass


func _on_Enemy_die():
	remain -= 1
	$Control/Label.text = "Remain: " + str(remain)
	if remain <= 0:
		print("You Win")
		pass