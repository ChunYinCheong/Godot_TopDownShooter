extends "res://item/ItemControl.gd"

onready var ammo_label = $VBoxContainer/Label2


# Called when the node enters the scene tree for the first time.
func _ready():
	item.connect("ammo_changed",self,"_on_Handgun_ammo_changed")
	ammo_label.text = "Ammo: " + str(item.ammo)
	pass # Replace with function body.

func _on_Handgun_ammo_changed(ammo):
	ammo_label.text = "Ammo: " + str(ammo)
	pass