class_name BackButton

extends Button

@onready var main_menu: VBoxContainer = %MainMenu
@onready var settings: TabContainer = %Settings
@onready var play: Button = $"../../../MenuContainer/MainMenu/Play"
@onready var text_box_container: Control = %MenuTextbox
@onready var menu_background_color = $"../../../MenuBackgroundColor"
@onready var settings_background_color = $"../../../SettingsBackgroundColor"


# Oculta el menú de opciones y muestra el menú principal:
func _on_pressed():
	menu_background_color.fade_in() # Realiza un fade in al fondo del menú
	settings.current_tab = 0 # Se selecciona la TabBar de Video
	main_menu.show() # Se muestra el menú principal
	text_box_container.show() # Se muestra el textbox del menú principal
	if !Mouse.mouse_mode_activated:
		play.grab_focus() # Se enfoca el botón play
	settings.hide() # Se oculta el menú de opciones de configuración
