extends Area

signal interact(unit)

onready var ui = $CenterContainer
var is_show = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_show:
		var pos = get_viewport().get_camera().unproject_position(self.global_transform.origin)
		ui.rect_global_position = pos - ui.rect_size / 2
	pass

func interact(unit):
	emit_signal("interact",unit)
	pass

func focus():
	is_show = true
	ui.show()
	pass

func blur():
	is_show = false
	ui.hide()
	pass
	