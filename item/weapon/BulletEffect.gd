extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer : float = 3.0
var destination : Vector3
var speed : float = 200.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if delta == 0:
		return
		
	var s = speed * delta
	if destination and destination.distance_to(self.global_transform.origin) <= s:
#		print("distance free")
		queue_free()
		return
		
	translate(Vector3(0, 0, -s ))
		
	timer = timer - delta
	if timer <= 0:
#		print("timer free")
		queue_free()
		return
				
	pass
