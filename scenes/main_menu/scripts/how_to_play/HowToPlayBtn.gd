extends Button

@onready var menu_textbox: MarginContainer = $"../../MenuTextbox/MarginContainer/MenuTextbox"
@export_multiline var hint: String = "En esta sección encontrarás todo lo necesario para aprender a jugar."
@onready var settings_background_color: ColorRect = $"../../../SettingsBackgroundColor"
@onready var menu_background_color: ColorRect = $"../../../MenuBackgroundColor"
@onready var how_to_play: TabContainer = %HowToPlay
@onready var text_box_container: VBoxContainer = %MenuTextbox


# Muestra el menú de las opciones de configuración y oculta el menú principal:
func _on_pressed() -> void:
	settings_background_color.show()
	menu_background_color.fade_out()
	how_to_play.show() # Muestra el menú de opciones
	if !Mouse.mouse_mode_activated:
		how_to_play.get_tab_bar().grab_focus() # Enfoca la TabBar de Video
	get_parent().hide() # Oculta el menú principal
	text_box_container.hide() # Oculta el textbox del menú principal.hide() # Oculta el textbox del menú principal
	%BackButton.show()
	

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
