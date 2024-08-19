extends Button

@onready var menu_textbox: MarginContainer = $"../../MenuTextbox/MarginContainer/MenuTextbox"
@export_multiline var hint: String = "En esta sección encontrarás todo lo necesario para aprender a jugar."
@onready var settings_background_color: ColorRect = $"../../../SettingsBackgroundColor"
@onready var menu_background_color: ColorRect = $"../../../MenuBackgroundColor"
@onready var how_to_play: TabContainer = %HowToPlay
@onready var text_box_container: VBoxContainer = %MenuTextbox
@onready var menu_container: HBoxContainer = $"../.."


# Muestra el menú de las opciones de configuración y oculta el menú principal:
func _on_pressed() -> void:
	self.settings_background_color.show()
	self.settings_background_color.fade_in()
	self.menu_background_color.fade_out()
	self.how_to_play.show() # Muestra el menú de opciones
	if !Mouse.mouse_mode_activated:
		self.how_to_play.get_tab_bar().grab_focus() # Enfoca la TabBar de Video
	else:
		%BackButton.show()
	self.menu_container.hide() # Oculta el menú principal
	self.text_box_container.hide() # Oculta el textbox del menú principal.hide() # Oculta el textbox del menú principal
	

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
