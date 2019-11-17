extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var camera = $Camera
var footman# = $Unit/FootmanUnit

# Called when the node enters the scene tree for the first time.
func _ready():
	var players = get_tree().get_nodes_in_group("Player")
	if not players.empty():
		footman = players[0]
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if camera and footman:
		camera.global_transform.origin.x = footman.global_transform.origin.x
		camera.global_transform.origin.z = footman.global_transform.origin.z + 5
	pass
	#$Control/VBoxContainer/HBoxContainer/TextureRect.texture
