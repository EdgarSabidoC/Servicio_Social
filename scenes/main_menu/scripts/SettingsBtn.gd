extends Button

@onready var settings: TabContainer = %Settings
@onready var video = $"../../../Settings/Video"
@onready var text_box_container: Control = %MenuTextbox
@onready var menu_background = %MenuBackground
@onready var settings_background_color = $"../../../SettingsBackgroundColor"
@onready var menu_background_color = $"../../../MenuBackgroundColor"
@export_multiline var hint: String = "Abre el menú de opciones de configuración:\n⚙️ Vídeo\n⚙️ Audio\n⚙️ Controles"
@onready var menu_textbox = $"../../MenuTextbox/MarginContainer/MenuTextbox"
@onready var menu_container: HBoxContainer = $"../.."


# Muestra el menú de las opciones de configuración y oculta el menú principal:
func _on_pressed() -> void:
	self.settings_background_color.show()
	self.settings_background_color.fade_in()
	self.menu_background_color.fade_out()
	self.settings.show() # Muestra el menú de opciones
	if !Mouse.mouse_mode_activated:
		self.settings.get_tab_bar().grab_focus() # Enfoca la TabBar de Video
	else:
		%BackButton.show()
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
