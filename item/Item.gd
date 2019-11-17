extends RigidBody

enum ITEM_TYPE { ONE_HANDED, TWO_HANDED }
export(ITEM_TYPE) var item_type = ITEM_TYPE.ONE_HANDED
export var item_name : String = "item"

var _mode
var _layer
var _mask

onready var interactiveArea = $InteractiveArea

func pickup():
	_mode = self.mode
	_layer = self.collision_layer
	_mask = self.collision_mask
	
	self.mode = RigidBody.MODE_STATIC
	self.collision_layer = 0
	self.collision_mask = 0
	
	interactiveArea.monitorable = false
	
func drop():
	self.mode = _mode
	self.collision_layer = _layer
	self.collision_mask = _mask

	interactiveArea.monitorable = true
	
func _on_InteractiveArea_interact(unit):
	pickup()
	unit.interact_weapon(self)
	pass # Replace with function body.
	
func create_control():
	var control = preload("res://item/ItemControl.tscn").instance()
	control.item = self
	return control
