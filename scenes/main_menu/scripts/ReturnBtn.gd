extends Button

@onready var difficulty_menu = %DifficultyMenu
@onready var main_menu = %MainMenu
@onready var menu_container = $"../../MenuContainer"
@onready var settings_background_color = $"../../SettingsBackgroundColor"
@onready var menu_background_color = $"../../MenuBackgroundColor"
@onready var menu_textbox = %MenuTextbox
@onready var play = $"../../MenuContainer/MainMenu/Play"


func _on_pressed() -> void:
	menu_background_color.fade_in() # Realiza un fade in al fondo del menú
	main_menu.show() # Se muestra el menú principal
	menu_textbox.show() # Se muestra el textbox del menú principal
	difficulty_menu.hide() # Se oculta el menú de opciones de configuración
	play.grab_focus() # Se enfoca el botón play
