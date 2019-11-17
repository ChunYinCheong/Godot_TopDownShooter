extends Area

signal captured (team)
signal released (team)
signal die


var capturing_team : int = 0
var captured_team : int = 0
var progress : float = 0
var unit_in_range : Array = []
var max_progress : float = 255

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if capturing_team != 0:
		if captured_team != 0 and capturing_team != captured_team:
			progress -= delta * 100
			if progress <= 0:
				var temp = captured_team
				captured_team = 0
				emit_signal("released", temp)
#				print("released! " , temp)				
		else:
			if progress == max_progress:
				return
			progress += delta * 100
			
		# Update appearance
		var blue = min(ceil(progress),255)
		var color = Color8(0,255,blue,255)
		$MeshInstance.material_override.albedo_color =  color
		
		if progress >= max_progress:
			progress = max_progress
			if captured_team != capturing_team:
				captured_team = capturing_team
				emit_signal("captured", captured_team)
#				print("captured! " , captured_team)
	pass

func _on_Concentrator_body_entered(body):
#	if body.is_in_group("Unit"):
	unit_in_range.append(body)
	update_capturing()
	pass # Replace with function body.

func _on_Concentrator_body_exited(body):
#	if body.is_in_group("Unit"):
	var index = unit_in_range.find(body)
	if index != -1:
		unit_in_range.remove(index)
	update_capturing()
	pass # Replace with function body.

func update_capturing():
	var dict = {}
	for unit in unit_in_range:
		var team = unit.get("team")
		if team:
			var count = dict.get(team, 0)
			count += 1
			dict[team] = count
	var capturing : int = 0
	var max_count : int = 0
	for key in dict:
		if not capturing:
			capturing = key
			max_count = dict[key]
		elif dict[key] == max_count:
			capturing = 0
		elif dict[key] > max_count:
			capturing = key
			max_count = dict[key]
	capturing_team = capturing
#	print("update_capturing: ",capturing_team)
	pass	

func _on_DestructibleArea_die():
	emit_signal("die")
	pass # Replace with function body.
