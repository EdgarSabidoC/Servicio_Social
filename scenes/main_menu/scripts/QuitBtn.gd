extends Button

@export_multiline var hint: String = "Cerrar el juego." 
@onready var menu_textbox = $"../../MenuTextbox/MarginContainer/MenuTextbox"


# Sale del juego/escena:
func _on_pressed() -> void:
	ClosingGame.exit = true
	get_tree().quit()


# Al estar enfocado el botón:
func _on_focus_entered():
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS, 10)
	if !Mouse.mouse_mode_activated:
		self.add_theme_stylebox_override("focus", get_theme_stylebox("hover", "Button"))
		self.add_theme_font_size_override("font_size", 24)
		self.menu_textbox.print_message(self.hint)


# Al salir de foco del botón:
func _on_focus_exited():
	if !Mouse.mouse_mode_activated:
		self.add_theme_font_size_override("font_size", 16)


# Al entrar el mouse al botón:
func _on_mouse_entered():
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS, 10)
	self.add_theme_font_size_override("font_size", 24)
	self.menu_textbox.print_message(self.hint)


# Al salir el mouse del botón:
func _on_mouse_exited():
	if !ClosingGame.exit:
		self.add_theme_font_size_override("font_size", 16)
		self.menu_textbox.clear_message()
