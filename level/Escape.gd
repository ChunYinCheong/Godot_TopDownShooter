extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var camera = $Camera
onready var footman = $Unit/FootmanUnit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera.global_transform.origin.x = footman.global_transform.origin.x
	camera.global_transform.origin.z = footman.global_transform.origin.z
	pass
	#$Control/VBoxContainer/HBoxContainer/TextureRect.texture
