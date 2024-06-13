extends Button

@onready var menu_textbox: MarginContainer = $"../../MenuTextbox/MarginContainer/MenuTextbox"
@export var hint: String = "En esta sección encontrarás todo lo necesario para aprender a jugar."


# Muestra el menú de las opciones de configuración y oculta el menú principal:
func _on_pressed() -> void:
	pass


# Al estar enfocado el botón:
func _on_focus_entered():
	self.add_theme_stylebox_override("focus", get_theme_stylebox("hover", "Button"))
	self.add_theme_font_size_override("font_size", 20)
	menu_textbox.print_message(self.hint)


# Al salir de foco del botón:
func _on_focus_exited():
	self.add_theme_font_size_override("font_size", 16)


# Al entrar el mouse al botón:
func _on_mouse_entered():
	self.add_theme_font_size_override("font_size", 20)
	menu_textbox.print_message(self.hint)


# Al salir el mouse del botón:
func _on_mouse_exited():
	self.add_theme_font_size_override("font_size", 16)
	menu_textbox.clear_message()
