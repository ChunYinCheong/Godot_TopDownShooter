extends Area

var objectInFront : Array = []
var current_focus : Area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var closest
	var closest_distance = -1
	for obj in objectInFront:
		var dis = self.global_transform.origin.distance_to(obj.global_transform.origin)
		if closest_distance == -1 or dis < closest_distance:
			closest = obj
			closest_distance = dis
		pass
	if closest and closest != current_focus:
		if current_focus:
			current_focus.blur()
		closest.focus()
		current_focus = closest
		pass
		
	pass


func _on_InteractArea_area_entered(area):
	objectInFront.append(area)
	pass # Replace with function body.


func _on_InteractArea_area_exited(area):	
	if area == current_focus:
		current_focus.blur()
		current_focus = null
	var index = objectInFront.find(area)
	if index != -1:
		objectInFront.remove(index)
	pass # Replace with function body.
