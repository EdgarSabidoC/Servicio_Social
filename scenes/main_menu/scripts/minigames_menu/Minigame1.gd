extends Button

@onready var menu_textbox: MarginContainer = $"../MarginContainer/MenuTextbox"
@export var hint: String = "Minijuego1"
@onready var difficulty_menu: VBoxContainer = %DifficultyMenu
@onready var margin_container: MarginContainer = $"../MarginContainer"
@onready var settings_background_color: ColorRect = $"../../SettingsBackgroundColor"
@onready var menu_background_color: ColorRect = $"../../MenuBackgroundColor"


# Al presionar el botón:
func _on_pressed() -> void:
	# Consume el evento:
	get_viewport().set_input_as_handled()
	# Moverse al menú de selección de dificultad:
	menu_background_color.fade_in()
	difficulty_menu.show()
	get_parent().hide() # Oculta el menú principal
	margin_container.hide()
	


# Cuando se vuelve visible:
func _on_visibility_changed():
	if !Mouse.mouse_mode_activated and self.is_visible_in_tree():
		self.grab_focus()


# Al estar enfocado el botón:
func _on_focus_entered():
	self.add_theme_stylebox_override("focus", get_theme_stylebox("hover", "Button"))
	self.add_theme_font_size_override("font_size", 20)
	menu_textbox.print_message(self.hint, "c")


# Al salir de foco del botón:
func _on_focus_exited():
	self.add_theme_font_size_override("font_size", 16)


# Al entrar el mouse al botón:
func _on_mouse_entered():
	self.add_theme_font_size_override("font_size", 20)
	menu_textbox.print_message(self.hint, "c")


# Al salir el mouse del botón:
func _on_mouse_exited():
	self.add_theme_font_size_override("font_size", 16)
	menu_textbox.clear_message("c")
