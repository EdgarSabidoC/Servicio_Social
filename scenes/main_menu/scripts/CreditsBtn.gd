extends Button

@export_multiline var hint: String = "Visualiza los créditos del juego."
@onready var _move_to: String = "res://scenes/credits/Credits.tscn"
@onready var menu_textbox = $"../../MenuTextbox/MarginContainer/MenuTextbox"
@onready var menu_container: HBoxContainer = $"../.."


func _on_pressed() -> void:
	# Comienza la animación de desvanecimiento y cambia de escena al final de la animación:
	SceneLoader.load_scene(self._move_to)


# Al estar enfocado el botón:
func _on_focus_entered():
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS, 10)
	self.add_theme_stylebox_override("focus", get_theme_stylebox("hover", "Button"))
	self.add_theme_font_size_override("font_size", 24)
	self.menu_textbox.print_message(self.hint)


# Al salir de foco del botón:
func _on_focus_exited():
	self.add_theme_font_size_override("font_size", 16)
	
	
# Al entrar el mouse al botón:
func _on_mouse_entered():
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS, 10)
	self.add_theme_font_size_override("font_size", 24)
	self.menu_textbox.print_message(self.hint)


# Al salir el mouse del botón:
func _on_mouse_exited():
	self.add_theme_font_size_override("font_size", 16)
	self.menu_textbox.clear_message()
