extends Button

@export var hint: String = "Comienza a jugar."
@export var seconds_to_wait = 3
@onready var difficulty_menu = %DifficultyMenu
@onready var text_box_container: Control = %MenuTextbox
@onready var menu_background_color = $"../../../MenuBackgroundColor"
@onready var settings_background_color = $"../../../SettingsBackgroundColor"

const MENU_BUTTONS: Texture2D = preload("res://assets/graphical_assets/user_interface/button/buttons.tga")


func _on_pressed() -> void:
	# Moverse al menú de selección de dificultad:
	settings_background_color.show()
	menu_background_color.fade_out()
	difficulty_menu.show()
	get_parent().hide() # Oculta el menú principal
	text_box_container.hide() # Oculta el textbox del menú principal


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
