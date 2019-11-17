extends Node


const system_save_path = "user://system.save"
var system : Dictionary setget ,get_system
enum MAIN_MENU_TYPE {BLACK = 1, SKY = 2, SNOW = 3}

var option


const character_save_path = "user://character.save"
var character

func backup_then_save(path, dict):
	var dir = Directory.new()
	if dir.file_exists(path):
		var datetime = OS.get_datetime(true)
		var s = str(OS.get_unix_time_from_datetime(datetime))
		dir.copy(path, str(path + "." + s + ".bak"))
	var file = File.new()
	file.open(path, File.WRITE)	
	file.store_line(to_json(dict))
	file.close()
	pass
	

func get_system():
	if system:
    	return system
	print("System Save not loaded!")
	return load_system()

func save_system():
	backup_then_save(system_save_path,system)
	pass
	
	
func load_system():
	var file = File.new()
	if file.file_exists(system_save_path):
		file.open(system_save_path, File.READ)
		var json = parse_json(file.get_as_text())
		file.close()
		system = json
	else:
		# Default system save
		system = {
			"version" : 1,
			"main_menu" : MAIN_MENU_TYPE.BLACK
		}
	return system
	
	

