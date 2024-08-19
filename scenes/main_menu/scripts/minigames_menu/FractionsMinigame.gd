extends Button

@onready var menu_textbox: MarginContainer = $"../MarginContainer/MenuTextbox"
@export_multiline var hint: String = "Fracciones"
@onready var difficulty_menu: VBoxContainer = %DifficultyMenu
@onready var margin_container: MarginContainer = $"../MarginContainer"
@onready var settings_background_color: ColorRect = $"../../SettingsBackgroundColor"
@onready var menu_background_color: ColorRect = $"../../MenuBackgroundColor"


# Al presionar el botón:
func _on_pressed() -> void:
	# Consume el evento:
	get_viewport().set_input_as_handled()
	# Moverse al menú de selección de dificultad:
	self.menu_background_color.fade_in()
	self.settings_background_color.fade_out()
	PlayerSession.current_minigame = PlayerSession.Minigames.FRACCTIONS
	if !PlayerSession.fractions_info_screen:
		%InfoScreen.start()
		await %InfoScreen.finished
	self.difficulty_menu.show()
	get_parent().hide() # Oculta el menú principal
	self.margin_container.hide()


# Al estar enfocado el botón:
func _on_focus_entered():
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS, 10)
	self.add_theme_stylebox_override("focus", get_theme_stylebox("hover", "Button"))
	self.add_theme_font_size_override("font_size", 24)
	self.menu_textbox.print_message(self.hint, "c")


# Al salir de foco del botón:
func _on_focus_exited():
	self.add_theme_font_size_override("font_size", 16)


# Al entrar el mouse al botón:
func _on_mouse_entered():
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS, 10)
	self.add_theme_font_size_override("font_size", 24)
	self.menu_textbox.print_message(self.hint, "c")


# Al salir el mouse del botón:
func _on_mouse_exited():
	self.add_theme_font_size_override("font_size", 16)
	self.menu_textbox.clear_message("c")
