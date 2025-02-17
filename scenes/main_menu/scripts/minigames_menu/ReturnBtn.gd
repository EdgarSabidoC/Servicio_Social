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
@onready var fractions_minigame: Button = $"../FractionsMinigame"



func _on_pressed() -> void:
	if PlayerSession.is_practice_mode():
		self.fractions_minigame.show()
		# Si está en el modo práctica, lo desactiva:
		PlayerSession.change_practice_mode()
	
	# Moverse al menú principal
	self.menu_background_color.fade_in()
	self.settings_background_color.fade_out()
	self.menu_container.show()
	self.main_menu.show()
	self.menu_textbox_container.show() # Se muestra el textbox del menú principal
	self.minigames_menu.hide() # Se oculta el menú de opciones de configuración
	if !Mouse.mouse_mode_activated:
		self.play_btn.grab_focus() # Se enfoca el botón play


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
