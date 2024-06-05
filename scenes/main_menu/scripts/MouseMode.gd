extends CheckButton


# Activa o desactiva el modo mouse:
func _on_toggled(_toggled_on):
	Mouse.change_mode()
