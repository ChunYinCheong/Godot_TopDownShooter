extends Node

var spell_dict : Dictionary = {
	"fire,fire,fire,": preload("res://skill/spell/Fireball.tscn"),
	"air,air,earth,": preload("res://skill/spell/Aegis.tscn")
}


func instance_spell(element : Array):
	var key = ""
	for e in element:
		key += e + ","
	var spell = spell_dict.get(key,null)
	if spell:
		return spell.instance()
	return null
	
	