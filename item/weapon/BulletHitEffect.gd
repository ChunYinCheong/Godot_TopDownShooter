extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer : float


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $Particles.lifetime
	$Particles.one_shot = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer = timer - delta
	if timer <= 0:
		queue_free()
	pass
