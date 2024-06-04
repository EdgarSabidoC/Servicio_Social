extends CheckButton


# Activa o desactiva el modo mouse:
func _on_toggled(toggled_on):
	Mouse.change_mode()
