extends Label

var timer : float = 3.0
var position_node : Spatial setget set_position_node
var global_translation : Vector3

func _ready():
	if global_translation:
		rect_global_position = get_viewport().get_camera().unproject_position(global_translation)
		$Tween.interpolate_property(self, "modulate", 
			Color(1, 1, 1, 1), Color(1, 1, 1, 0), timer, 
			Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()
			
	else:
		printerr("FadeLabel - Missing position_node or global_translation")
		push_error("FadeLabel - Missing position_node or global_translation")
		breakpoint
		pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	if timer <= 0:
		queue_free()
	rect_global_position = get_viewport().get_camera().unproject_position(global_translation)
	pass

func set_position_node(new_value : Spatial):
	position_node = new_value
	if position_node:
		global_translation = position_node.global_transform.origin
		
		
	