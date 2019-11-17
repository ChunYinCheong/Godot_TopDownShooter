extends "res://item/ItemControl.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var energy_label = $VBoxContainer/Label2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	energy_label.text = "Energy: " + str(int(item.primary_energy.energy))
	pass
