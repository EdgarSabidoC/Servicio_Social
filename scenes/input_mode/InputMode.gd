extends Control


# Activa el modo teclado:
func _on_keyboard_mode_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Mouse.enable_actions()
	Mouse.change_mode()
	# Aquí se debe hacer el cambio de escena.


# Activa el modo ratón:
func _on_mouse_mode_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Mouse.disable_actions()
	Mouse.change_mode()
	# Aquí se debe hacer el cambio de escena.
