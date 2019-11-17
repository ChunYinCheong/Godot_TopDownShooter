extends Node


signal begin_channeling
signal begin_casting
signal start_effect
signal finish_casting
signal stop_casting
signal stop_channeling

export var spell_name : String = "Spell Name!"
export var spell_icon : Texture = preload("res://asset/spell/icon_focused.png")

export var activating_movement_speed_adjust : float = 1
export var activating_turning_speed_adjust : float = 1
export var mp : float = 0

var effect_point : float = 0
var effect_duration : float = 0

var state = "init"
var casting_unit
var target_position : Vector3


func _process(delta):
	if state == "begin_casting":
		if effect_point <= delta:
			var d = delta - effect_point
			effect_point = 0
			start_effect()
			if effect_duration <= d:
				_effect(effect_duration)
				effect_duration = 0
				finish_casting()
			else:
				_effect(d)
				effect_duration -= d
		else:			
			effect_point -= delta
		return
	elif state == "start_effect":
		if effect_duration <= delta:
			_effect(effect_duration)
			effect_duration = 0
			finish_casting()
		else:
			_effect(delta)
			effect_duration -= delta
		return
	pass
	

func begin_channeling():
	# After channeling element, in channeling stack
	# To begin_casting or stop_channeling
	emit_signal("begin_channeling")
	pass
	
func begin_casting(target_position):
	# Pressed fire and popup form stack
	# To start_effect or stop_casting
	state = "begin_casting"
	self.target_position = target_position
	emit_signal("begin_casting")
	pass
	
func start_effect():
	# Start the spell
	# To finish_casting or stop_casting
	state = "start_effect"
	_start_effect()
	emit_signal("start_effect")
	pass

func _start_effect():
	pass

func _effect(delta):
	pass
	
func finish_casting():
	# Finished without cancel
	# To stop_casting
	
	# Avoid stop_casting twice
	# stop_casting()
	state = "finish_casting"
	_finish_casting()
	emit_signal("finish_casting")
	pass

func _finish_casting():
	pass
	
func stop_casting():
	# After casting finished or Canceled
	# Release fire
	# To stop_channeling
	emit_signal("stop_casting")
	pass
	
func stop_channeling():
	# End and Clean up
	queue_free()
	emit_signal("stop_channeling")
	pass
