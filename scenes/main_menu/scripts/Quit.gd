extends Button

@export var hint: String = "Cerrar el juego." 


# Sale del juego/escena:
func _on_pressed() -> void:
	get_tree().quit()


# Al estar enfocado el botón:
func _on_focus_entered():
	self.add_theme_stylebox_override("focus", get_theme_stylebox("hover", "Button"))
	self.add_theme_font_size_override("font_size", 20)


# Al salir de foco del botón:
func _on_focus_exited():
	self.add_theme_font_size_override("font_size", 16)


# Al entrar el mouse al botón:
func _on_mouse_entered():
	self.add_theme_font_size_override("font_size", 20)


# Al salir el mouse del botón:
func _on_mouse_exited():
	self.add_theme_font_size_override("font_size", 16)
