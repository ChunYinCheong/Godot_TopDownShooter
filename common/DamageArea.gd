extends Area

signal die

export var hp : float = 1000
export var armor : float = 50

onready var hp_label = $HpLabel

func take_damage(dict : Dictionary):
#	print("take_damage" , dict)
	var damage = dict.get("damage", 0)
	var penetrator = dict.get("penetrator", 0)
	var result = max(damage - max(armor-penetrator,0), 0) 
	hp -= result
	if hp <=0 :
		self.monitorable = false
		emit_signal("die")
	pass
	
func _process(delta):
	var pos = get_viewport().get_camera().unproject_position(self.global_transform.origin)
	hp_label.text = str(hp)
	hp_label.rect_global_position = pos
	pass