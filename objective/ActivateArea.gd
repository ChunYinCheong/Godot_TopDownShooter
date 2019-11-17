extends Area

onready var ui = $CenterContainer
onready var lIcon = $CenterContainer/LIcon
onready var l2Icon = $CenterContainer/L2Icon
var player 

export var element_list : Array = []

var icons : Dictionary = {
	"down": preload("res://asset/icon/down.png"),
	"down_dark": preload("res://asset/icon/down_dark.png"),
	"down_light": preload("res://asset/icon/down_light.png"),
	"up": preload("res://asset/icon/up.png"),
	"up_dark": preload("res://asset/icon/up_dark.png"),
	"up_light": preload("res://asset/icon/up_light.png"),
	"left": preload("res://asset/icon/left.png"),
	"left_dark": preload("res://asset/icon/left_dark.png"),
	"left_light": preload("res://asset/icon/left_light.png"),
	"right": preload("res://asset/icon/right.png"),
	"right_dark": preload("res://asset/icon/right_dark.png"),
	"right_light": preload("res://asset/icon/right_light.png"),
}

func _ready():
	for i in range(element_list.size()):
		$CenterContainer/HBoxContainer.add_child(TextureRect.new())
	pass
	
func _process(delta):
	if player:
		var pos = get_viewport().get_camera().unproject_position(self.global_transform.origin)
		ui.rect_global_position = pos - ui.rect_size / 2
		var a : Array = []
		for a in player.channeling_alchemy:
			if a is preload("res://skill/alchemy/ActivateTeleportStone.gd"):
				l2Icon.show()
				lIcon.hide()
				$CenterContainer/HBoxContainer.hide()
				return
		if not player.channeling:
			l2Icon.hide()
			lIcon.show()
			$CenterContainer/HBoxContainer.hide()
		else:
			l2Icon.hide()
			lIcon.hide()
			$CenterContainer/HBoxContainer.show()
			
		var m = true
		for i in range(player.channeled_alchemy_element.size()):
			var e = player.channeled_alchemy_element[i]
			if e["element"] == element_list[i]:
				pass
			else:
				m = false
				break
		if not m:
			# Not match, all dark
			for i in range(element_list.size()):
				var tr : TextureRect = $CenterContainer/HBoxContainer.get_child(i)
				var e = element_list[i]
				tr.texture = icons[e + "_dark"]			
			pass
		else:
			# light / normal			
			for i in range(element_list.size()):
				var tr : TextureRect = $CenterContainer/HBoxContainer.get_child(i)
				var e = element_list[i]
				if i < player.channeled_alchemy_element.size():
					tr.texture = icons[e + "_light"]			
				else:
					tr.texture = icons[e]			
			pass
		
#		print(str(player.channeled_spell_element))
	pass

func _on_ActivateArea_body_entered(body):
	player = body
	var pos = get_viewport().get_camera().unproject_position(self.global_transform.origin)
	ui.rect_global_position = pos - ui.rect_size / 2
	ui.show()
	pass # Replace with function body.


func _on_ActivateArea_body_exited(body):
	player = null
	ui.hide()
	pass # Replace with function body.
