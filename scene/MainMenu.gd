extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var start_button = $MarginContainer/VBoxContainer/Button

# Called when the node enters the scene tree for the first time.
func _ready():
	SaveData.load_system()
	print(SaveData.system.main_menu)
	if SaveData.system.main_menu == SaveData.MAIN_MENU_TYPE.BLACK:
		$Particles2D.emitting = false
		start_button.text = "Start"		
		pass
	elif SaveData.system.main_menu == SaveData.MAIN_MENU_TYPE.SKY:
		$ColorRect.color = Color.dimgray
		start_button.text = "Continue"		
		pass
	elif SaveData.system.main_menu == SaveData.MAIN_MENU_TYPE.SNOW:
		start_button.text = "Continue"				
		pass
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Button_pressed():
	if SaveData.system.main_menu == SaveData.MAIN_MENU_TYPE.BLACK:
		$Fade.visible = true
		$AnimationPlayer.play("Fade")
		#get_tree().change_scene("res://path/to/scene.tscn")
		pass
	elif SaveData.system.main_menu == SaveData.MAIN_MENU_TYPE.SKY:
		get_tree().change_scene("res://scene/GoHome.tscn")
		pass
	elif SaveData.system.main_menu == SaveData.MAIN_MENU_TYPE.SNOW:
		get_tree().change_scene("res://scene/GoHome.tscn")
		pass
	pass # Replace with function body.


func _on_Button3_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade":
		get_tree().change_scene("res://scene/Opening.tscn")		
		pass
	pass # Replace with function body.
