extends Button

@export_multiline var hint: String = "Selecciona uno de los minijuegos y comienza a jugar."
@export var seconds_to_wait = 3
@onready var difficulty_menu = %DifficultyMenu
@onready var text_box_container: Control = %MenuTextbox
@onready var menu_background_color = $"../../../MenuBackgroundColor"
@onready var settings_background_color = $"../../../SettingsBackgroundColor"
@onready var menu_textbox = $"../../MenuTextbox/MarginContainer/MenuTextbox"
@onready var minigames_menu: VBoxContainer = %MinigamesMenu
@onready var menu_container: HBoxContainer = $"../.."

const MENU_BUTTONS: Texture2D = preload("res://assets/graphical_assets/user_interface/button/buttons.tga")


func _on_pressed() -> void:
	# Moverse al menú de selección de dificultad:
	self.settings_background_color.show()
	self.settings_background_color.fade_in()
	self.menu_background_color.fade_out()
	self.minigames_menu.show()
	self.menu_container.hide() # Oculta el menú principal
	self.text_box_container.hide() # Oculta el textbox del menú principal


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
	
