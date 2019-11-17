extends StaticBody

signal die

func _on_DestructibleArea_die():
	emit_signal("die")
	queue_free()
	pass # Replace with function body.
