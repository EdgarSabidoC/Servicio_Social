extends Control

@onready var play_btn: Button = $MainMenu/PlayBtn
@onready var settings_btn: Button = $MainMenu/SettingsBtn
@onready var quit_btn: Button = $MainMenu/QuitBtn
@onready var menu_textbox: MarginContainer = $MenuTextbox/MarginContainer/MenuTextbox

var current_button: Button = null
var last_size: Vector2i
var margin_value: int


signal main_window_size_changed()


func _ready() -> void:
	# Si el modo mouse está desactivado se enfoca el botón Play:
	if !Mouse.mouse_mode_activated:
		play_btn.grab_focus()
		
	menu_textbox.print_message(menu_textbox.default_text)
	# Se obtiene el tamaño de pantalla actual:
	#last_size = DisplayServer.window_get_size()
	
	# Se conecta la señal:
	#main_window_size_changed.connect(_on_main_window_size_changed)
	#main_window_size_changed.emit()


# Señal personalizada que se emite cuando se cambia el tamaño de la ventana:
func _on_main_window_size_changed():
	var actual_size: Vector2i = DisplayServer.window_get_size()
	var textbox_font: RichTextLabel = menu_textbox.get_child(0)
	var textbox_font_size: int
	var button_font_size: int
	
	# Se valida si el último tamaño de la pantalla es más pequeño que el actual:
	if last_size < actual_size:
		margin_value = 55
		textbox_font_size = 22
		button_font_size = 20
	else:
		margin_value = 45
		textbox_font_size = 16
		button_font_size = 18
	
	# Se sobreescriben los márgenes del textbox:
	menu_textbox.add_theme_constant_override("margin_top", margin_value)
	menu_textbox.add_theme_constant_override("margin_left", margin_value)
	menu_textbox.add_theme_constant_override("margin_bottom", margin_value)
	menu_textbox.add_theme_constant_override("margin_right", margin_value)
	
	# Se sobreescribe el tamaño de la fuente normal del textbox:
	textbox_font.add_theme_font_size_override("normal_font_size", textbox_font_size)
	
	# Se sobreescriben los tamaños de fuente de los botones:
	play_btn.add_theme_font_size_override("font_size", button_font_size)
	settings_btn.add_theme_font_size_override("font_size", button_font_size)
	quit_btn.add_theme_font_size_override("font_size", button_font_size)
	
	# Se actualiza el último tamaño:
	last_size = DisplayServer.window_get_size()
