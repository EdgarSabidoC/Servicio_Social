extends Button

@export var hint: String = "Regresar al menú principal"
@onready var difficulty_menu: VBoxContainer = %DifficultyMenu
@onready var settings_background_color = $"../../SettingsBackgroundColor"
@onready var menu_background_color = $"../../MenuBackgroundColor"
@onready var menu_textbox_container = %MenuTextbox
@onready var fractions_minigame: Button = $"../../MinigamesMenu/FractionsMinigame"
@onready var menu_textbox: MarginContainer = $"../MarginContainer/MenuTextbox"
@onready var minigames_menu: VBoxContainer = %MinigamesMenu
@onready var margin_container: MarginContainer = $"../../MinigamesMenu/MarginContainer"
@onready var additions_minigame: Button = $"../../MinigamesMenu/AdditionsMinigame"


func _on_pressed() -> void:
	# Moverse al menú principal
	self.settings_background_color.fade_in()
	self.menu_background_color.fade_out()
	self.margin_container.show() # Se muestra el contenedor del textbox del menú de minijuegos
	self.minigames_menu.show() # Se muestra el menú de minijuegos
	self.difficulty_menu.hide() # Se oculta el menú de opciones de dificultad


# Al estar enfocado el botón:
func _on_focus_entered():
	self.add_theme_stylebox_override("focus", get_theme_stylebox("hover", "Button"))
	self.add_theme_font_size_override("font_size", 24)
	self.menu_textbox.print_message(self.hint, "c")


# Al salir de foco del botón:
func _on_focus_exited():
	self.add_theme_font_size_override("font_size", 16)


# Al entrar el mouse al botón:
func _on_mouse_entered():
	self.add_theme_font_size_override("font_size", 24)
	self.menu_textbox.print_message(self.hint, "c")


# Al salir el mouse del botón:
func _on_mouse_exited():
	self.add_theme_font_size_override("font_size", 16)
	self.menu_textbox.clear_message("c")
