extends Button

@export_multiline var hint: String = "Perfecciona tus habilidades o familiarízate con los minijuegos.\n\nEl reloj y el puntaje están desactivados."
@export var seconds_to_wait = 3
@onready var difficulty_menu = %DifficultyMenu
@onready var text_box_container: Control = %MenuTextbox
@onready var menu_background_color = $"../../../MenuBackgroundColor"
@onready var settings_background_color = $"../../../SettingsBackgroundColor"
@onready var menu_textbox = $"../../MenuTextbox/MarginContainer/MenuTextbox"
@onready var minigames_menu: VBoxContainer = %MinigamesMenu
@onready var menu_container: HBoxContainer = $"../.."


func _on_pressed() -> void:
	# Se activa el modo práctica:
	PlayerSession.change_practice_mode()
	
	# Moverse al menú de selección de dificultad:
	settings_background_color.show()
	menu_background_color.fade_out()
	minigames_menu.show()
	menu_container.hide() # Oculta el menú principal
	text_box_container.hide() # Oculta el textbox del menú principal


# Al estar enfocado el botón:
func _on_focus_entered():
	self.add_theme_stylebox_override("focus", get_theme_stylebox("hover", "Button"))
	self.add_theme_font_size_override("font_size", 24)
	menu_textbox.print_message(self.hint)


# Al salir de foco del botón:
func _on_focus_exited():
	self.add_theme_font_size_override("font_size", 16)


# Al entrar el mouse al botón:
func _on_mouse_entered():
	self.add_theme_font_size_override("font_size", 24)
	menu_textbox.print_message(self.hint)


# Al salir el mouse del botón:
func _on_mouse_exited():
	self.add_theme_font_size_override("font_size", 16)
	menu_textbox.clear_message()
