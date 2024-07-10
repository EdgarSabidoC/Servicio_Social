extends Button

@export_multiline var hint: String = "Regresar al menú principal"
@onready var minigames_menu: VBoxContainer = %MinigamesMenu
@onready var main_menu = %MainMenu
@onready var menu_container = $"../../MenuContainer"
@onready var settings_background_color = $"../../SettingsBackgroundColor"
@onready var menu_background_color = $"../../MenuBackgroundColor"
@onready var menu_textbox_container = %MenuTextbox
@onready var play_btn: Button = $"../../MenuContainer/MainMenu/PlayBtn"
@onready var menu_textbox: MarginContainer = $"../MarginContainer/MenuTextbox"


func _on_pressed() -> void:
	menu_background_color.fade_in() # Realiza un fade in al fondo del menú
	main_menu.show() # Se muestra el menú principal
	menu_textbox_container.show() # Se muestra el textbox del menú principal
	minigames_menu.hide() # Se oculta el menú de opciones de configuración
	if !Mouse.mouse_mode_activated:
		play_btn.grab_focus() # Se enfoca el botón play


# Al estar enfocado el botón:
func _on_focus_entered():
	self.add_theme_stylebox_override("focus", get_theme_stylebox("hover", "Button"))
	self.add_theme_font_size_override("font_size", 24)
	menu_textbox.print_message(self.hint, "c")


# Al salir de foco del botón:
func _on_focus_exited():
	self.add_theme_font_size_override("font_size", 16)


# Al entrar el mouse al botón:
func _on_mouse_entered():
	self.add_theme_font_size_override("font_size", 24)
	menu_textbox.print_message(self.hint, "c")


# Al salir el mouse del botón:
func _on_mouse_exited():
	self.add_theme_font_size_override("font_size", 16)
	menu_textbox.clear_message("c")
