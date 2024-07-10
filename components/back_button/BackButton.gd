extends Button

## Button that returns to main menu
class_name BackButton


@onready var main_menu: VBoxContainer = %MainMenu
@onready var settings: TabContainer = %Settings
@onready var play_btn: Button = $"../MenuContainer/MainMenu/PlayBtn"
@onready var text_box_container: Control = %MenuTextbox
@onready var menu_background_color = $"../MenuBackgroundColor"
@onready var settings_background_color = $"../SettingsBackgroundColor"
@onready var how_to_play: TabContainer = %HowToPlay

func _ready() -> void:
	self.text = "Regresar"
	self.pressed.connect(self.on_pressed)


# Oculta el menú de opciones y muestra el menú principal:
func on_pressed():
	if settings.is_visible_in_tree():
		menu_background_color.fade_in() # Realiza un fade in al fondo del menú
		settings.current_tab = 0 # Se selecciona la TabBar de Video
		main_menu.show() # Se muestra el menú principal
		text_box_container.show() # Se muestra el textbox del menú principal
		if !Mouse.mouse_mode_activated:
			play_btn.grab_focus() # Se enfoca el botón play
		settings.hide() # Se oculta el menú de opciones de configuración
	elif how_to_play.is_visible_in_tree():
		menu_background_color.fade_in() # Realiza un fade in al fondo del menú
		how_to_play.current_tab = 0 # Se selecciona la TabBar de Video
		main_menu.show() # Se muestra el menú principal
		text_box_container.show() # Se muestra el textbox del menú principal
		if !Mouse.mouse_mode_activated:
			play_btn.grab_focus() # Se enfoca el botón play
		how_to_play.hide() # Se oculta el menú de opciones de configuración
	self.hide()
