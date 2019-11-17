extends Spatial

var player
#
# Channeling
#
var channeling : bool = false
var channeling_element : Dictionary = {}
var channeling_skill : Array = [] 
var casting_index : int = 0
var casting

#
# Channenling Spell
#
var channeled_spell_element : Array = []

#
# Channenling Alchemy
#
var channeled_alchemy_element : Array = []

func _ready():
	player = get_parent().get_parent().get_parent()
	player.connect("begin_channeling_element", self, "_on_Player_begin_channeling_element")
	player.connect("stop_channeling_element", self, "_on_Player_stop_channeling_element")
	
func _process(delta):
	if channeling:
		for e in channeling_element.keys():
			channeling_element[e]["duration"] += delta
			
func _on_Player_begin_channeling_element(element):
	if not channeling:
		return
	if (element == "fire"
		or element == "water"
		or element == "air"
		or element == "earth"
	):
		begin_channeling_spell_element(element)
	if  (element == "up"
		or element == "down"
		or element == "left"
		or element == "right"
	):
		begin_channeling_alchemy_element(element)
	pass
	
func _on_Player_stop_channeling_element(element):
	if not channeling:
		return
	if (element == "fire"
		or element == "water"
		or element == "air"
		or element == "earth"
	):
		stop_channeling_spell_element(element)
	if  (element == "up"
		or element == "down"
		or element == "left"
		or element == "right"
	):
		stop_channeling_alchemy_element(element)
	pass
	
# 
# Channeling
#
func begin_channeling():
	if channeling:
		stop_channeling()
	channeling = true
	pass

#	
# Chaneeling - Spell
#
func begin_channeling_spell_element(element : String):
	var i 
	if element == "fire":
		i = preload("res://skill/spell/element/FireElement.tscn").instance()
	elif element == "water":
		i = preload("res://skill/spell/element/WaterElement.tscn").instance()
	elif element == "air":
		i = preload("res://skill/spell/element/AirElement.tscn").instance()
	elif element == "earth":
		i = preload("res://skill/spell/element/EarthElement.tscn").instance()
	else:
		printerr("FootmanUnit - Unknown element in begin_channeling_spell_element")
		push_error("FootmanUnit - Unknown element in begin_channeling_spell_element")
		breakpoint
	i.begin_channeling()
	$SpellElements.add_child(i)
	channeling_element[element] = {
		"element": element,
		"duration": 0,
		"instance": i
	}
	pass

func stop_channeling_spell_element(element : String):
	channeled_spell_element.append(channeling_element[element])
	channeling_element[element]["instance"].stop_channeling()
	channeling_element.erase(element)
	# Check Spell
	var spell = null #Spell.instance_spell(channeling_element)
	if spell:
		for e in channeled_spell_element:
			e["instance"].release()
		channeled_spell_element.clear()
		begin_channeling_skill(spell)
	pass
	
#	
# Chaneeling - Alchemy
#
func begin_channeling_alchemy_element(element : String):
	var i 
	if element == "up":
		i = preload("res://skill/alchemy/element/UpElement.tscn").instance()
	elif element == "down":
		i = preload("res://skill/alchemy/element/DownElement.tscn").instance()
	elif element == "left":
		i = preload("res://skill/alchemy/element/LeftElement.tscn").instance()
	elif element == "right":
		i = preload("res://skill/alchemy/element/RightElement.tscn").instance()
	else:
		printerr("FootmanUnit - Unknown element in begin_channeling_alchemy_element")
		push_error("FootmanUnit - Unknown element in begin_channeling_alchemy_element")
		breakpoint
	i.begin_channeling()
	$AlchemyElements.add_child(i)
	channeling_element[element] = {
		"element": element,
		"duration": 0,
		"instance": i
	}
	pass

func stop_channeling_alchemy_element(element : String):
	if not channeling_element.has(element):
		return
	channeled_alchemy_element.append(channeling_element[element])
	channeling_element[element]["instance"].stop_channeling()
	channeling_element.erase(element)
	# Check alchemy
	var alchemy = null #alchemy.instance_alchemy(channeling_element)
	if channeled_alchemy_element.size() == 5:
		if (channeled_alchemy_element[0]["element"] == "up"  
			and channeled_alchemy_element[1]["element"] == "down"
			and channeled_alchemy_element[2]["element"] == "right"
			and channeled_alchemy_element[3]["element"] == "left"
			and channeled_alchemy_element[4]["element"] == "up"):
			alchemy = preload("res://skill/alchemy/ActivateTeleportStone.tscn").instance()
			pass
	elif channeled_alchemy_element.size() == 3:
		if (channeled_alchemy_element[0]["element"] == "right"  
			and channeled_alchemy_element[1]["element"] == "right"
			and channeled_alchemy_element[2]["element"] == "up"):
			alchemy = preload("res://skill/alchemy/item/weapon/CreateMachineGun.tscn").instance()
			pass
		elif (channeled_alchemy_element[0]["element"] == "right"  
			and channeled_alchemy_element[1]["element"] == "right"
			and channeled_alchemy_element[2]["element"] == "down"):
			alchemy = preload("res://skill/alchemy/item/weapon/CreateHandgun.tscn").instance()
			pass
	if alchemy:
		for e in channeled_alchemy_element:
			e["instance"].release()
		channeled_alchemy_element.clear()
		begin_channeling_skill(alchemy)
	pass
	
#
# Common
#
	
func begin_channeling_skill(spell):
	var label = preload("res://common/FadeLabel.tscn").instance()
	label.text = spell.name
	label.position_node = self
	get_tree().current_scene.add_child(label)
	add_child(spell)
	spell.begin_channeling()
	channeling_skill.append(spell)
	pass

func begin_casting():
	if casting:
		stop_casting()
	if channeling_skill.size() > casting_index:
		casting = channeling_skill[casting_index]
		casting_index += 1
		casting.begin_casting()
		pass
	pass
	
func stop_casting():
	if casting:
		casting.stop_casting()	
		casting = null
	pass
	

func stop_channeling_skill(spell):
	spell.stop_channeling()
	pass

func stop_channeling():
	channeling = false
	casting_index = 0
	
	for key in channeling_element.keys():
		channeling_element[key]["instance"].release()
	channeling_element.clear()
	
	for c in channeling_skill:
		c.stop_channeling()
	channeling_skill.clear()
	
	# Spell
	for element in channeled_spell_element:
		element["instance"].release()
	channeled_spell_element.clear()
	
	# Alchemy
	for element in channeled_alchemy_element:
		element["instance"].release()
	channeled_alchemy_element.clear()

	
	pass
	