extends Control

#const Item = preload("res://item/Item.gd")

onready var name_label = $VBoxContainer/Label
var item

# Called when the node enters the scene tree for the first time.
func _ready():
	name_label.text = item.item_name
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
