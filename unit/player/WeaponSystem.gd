extends Spatial

const Weapon = preload("res://item/weapon/Weapon.gd")
const Item = preload("res://item/Item.gd")


signal weapon_changed(ws)

#
# Weapon
#
var one_handed_weapon : Array = []
var two_handed_weapon : Array = []
var weapons : Array = []
const max_weapons = 3
var weapon_index : int = 0

onready var primary : Weapon  = $RightHand
onready var sidearm : Weapon  = $LeftHand

enum Mode { SINGLE, DUAL }
var mode = Mode.SINGLE

var is_pressing_switch_weapon : bool = false
var switch_weapons_duration = 0

var weapon2 setget ,get_weapon2
func get_weapon2():
	var i = (weapon_index + 1) % max_weapons
	if i >= weapons.size():
		return $RightHand
	else:
		return weapons[i]
var weapon3 setget ,get_weapon3
func get_weapon3():
	var i = (weapon_index + 2) % max_weapons
	if i >= weapons.size():
		return $RightHand
	else:
		return weapons[i]

func _ready():
	emit_signal("weapon_changed",self)
	

func _process(delta):
	if is_pressing_switch_weapon:
		switch_weapons_duration += delta
		if switch_weapons_duration > 0.5:
			is_pressing_switch_weapon = false
			switch_mode()
	pass

func interact_weapon(w :Weapon):
	if weapons.size() >= max_weapons:
		var current = weapons[weapon_index]
		current.drop()
		self.remove_child(current)
		get_tree().current_scene.add_child(current)
		
		weapons[weapon_index] = w
#		w.transform = self.global_transform
	else:
		weapons.append(w)		
		weapon_index = weapons.size() - 1
		
	w.get_parent().remove_child(w)
	self.add_child(w)
	w.translation = Vector3()
	w.rotation = Vector3()
	
	update_primary_and_sidearm()
	pass

func switch_weapons():
	weapon_index += 1
	if weapon_index >= max_weapons:
		weapon_index = 0
	
	primary.release_all()
	sidearm.release_all()
	update_primary_and_sidearm()
	pass
	
func switch_mode():	
	if mode == Mode.SINGLE:
		mode = Mode.DUAL
	elif mode == Mode.DUAL:
		mode = Mode.SINGLE
	else:
		push_error("Unknown mode")
	update_primary_and_sidearm()
		
func update_primary_and_sidearm():	
	if weapon_index >= weapons.size():
		primary = $RightHand
		sidearm = $LeftHand
	else:
		primary = weapons[weapon_index]
		if primary.item_type == Item.ITEM_TYPE.TWO_HANDED:
			sidearm = $LeftHand
		elif primary.item_type == Item.ITEM_TYPE.ONE_HANDED:
			if mode == Mode.DUAL:
				# Defaul if no other one handed weapon
				sidearm = $LeftHand
				for i in range(weapons.size() - 1):
					var index = (i + 1 + weapon_index) % weapons.size()
					if weapons[index].item_type == Item.ITEM_TYPE.ONE_HANDED:
						sidearm = weapons[index]
						break
			else:
				sidearm = $LeftHand
		else:
			push_error("Error: ")
	print(" weapons size: ",weapons.size()," weapons index: ",weapon_index," primary: ",primary.name, " sidearm: ",sidearm.name)
	emit_signal("weapon_changed",self)
	pass
	
func handle_input(event:InputEvent):
	if primary.item_type == Item.ITEM_TYPE.TWO_HANDED:
		if not (sidearm.holding_attack or sidearm.holding_special):
			if event.is_action_pressed("primary_attack"):
				primary.attack_pressed()
				return
			if event.is_action_released("primary_attack"):
				primary.attack_released()
				return
			if event.is_action_pressed("primary_special"):
				primary.special_pressed()
				return
			if event.is_action_released("primary_special"):
				primary.special_released()
				return
		if not (primary.holding_attack or primary.holding_special):
			if event.is_action_pressed("sidearm_attack"):
				sidearm.attack_pressed()
				return
			if event.is_action_released("sidearm_attack"):
				sidearm.attack_released()
				return
			if event.is_action_pressed("sidearm_special"):
				sidearm.special_pressed()
				return
			if event.is_action_released("sidearm_special"):
				sidearm.special_released()
				return
	else:
		if event.is_action_pressed("primary_attack"):
			primary.attack_pressed()
			return
		if event.is_action_released("primary_attack"):
			primary.attack_released()
			return
		if event.is_action_pressed("primary_special"):
			primary.special_pressed()
			return
		if event.is_action_released("primary_special"):
			primary.special_released()
			return
		
		if event.is_action_pressed("sidearm_attack"):
			sidearm.attack_pressed()
			return
		if event.is_action_released("sidearm_attack"):
			sidearm.attack_released()
			return
		if event.is_action_pressed("sidearm_special"):
			sidearm.special_pressed()
			return
		if event.is_action_released("sidearm_special"):
			sidearm.special_released()
			return
		
	
	if event.is_action_pressed("melee"):
		primary.melee_pressed()
		return
	
	if event.is_action_released("melee"):
		primary.melee_released()
		return
	
	if event.is_action_pressed("switch_weapons"):
		is_pressing_switch_weapon = true
		switch_weapons_duration = 0.0
		return
		
	if event.is_action_released("switch_weapons"):
		if is_pressing_switch_weapon:
			switch_weapons()
		is_pressing_switch_weapon = false
		return
	pass

func is_channeling():
	return $RightHand/Channeling.channeling or $LeftHand/Channeling.channeling 