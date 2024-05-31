extends VBoxContainer

var last_size: Vector2i
var margin_value: int

@onready var easy_btn = $EasyBtn
@onready var medium_btn = $MediumBtn
@onready var hard_btn = $HardBtn
@onready var return_btn = $ReturnBtn
@onready var menu_textbox = $MarginContainer/MenuTextbox
@onready var placeholder_1 = $Placeholder1
@onready var placeholder_2 = $Placeholder2


func _ready() -> void:
	# Se obtiene el tamaño de pantalla actual:
	#last_size = DisplayServer.window_get_size()
	
	# Se conecta la señal:
	#main_window_size_changed.connect(_on_main_window_size_changed)
	#main_window_size_changed.emit()
	pass


func _process(_delta) -> void:

	# Se verifica si hubo un cambio en el tamaño de la pantalla:
	#if last_size != DisplayServer.window_get_size():
		# Se emite la señal:
		#main_window_size_changed.emit()
	pass


# Señal personalizada que se emite cuando se cambia el tamaño de la ventana:
func _on_main_window_size_changed():
	var actual_size: Vector2i = DisplayServer.window_get_size()
	var textbox_font: RichTextLabel = menu_textbox.get_child(0)
	var textbox_font_size: int
	var button_font_size: int
	var placeholder_size: Vector2i
	var button_size: Vector2i
	var return_btn_size: Vector2i
	
	# Se valida si el último tamaño de la pantalla es más pequeño que el actual:
	if last_size < actual_size:
		margin_value = 60
		textbox_font_size = 28
		button_font_size = 40
		placeholder_size = Vector2i(0,100)
		button_size = Vector2i(250, 125)
		return_btn_size = Vector2i(250, 100)
	else:
		margin_value = 55
		textbox_font_size = 20
		button_font_size = 25
		placeholder_size = Vector2i(0,50)
		button_size = Vector2i(200, 75)
		return_btn_size = Vector2i(200, 50)
	
	# Se sobreescribe el tamaño vertical de los placeholders:
	placeholder_1.custom_minimum_size = placeholder_size
	placeholder_2.custom_minimum_size = placeholder_size
	
	# Se sobreescribe el márgen superior del textbox:
	menu_textbox.add_theme_constant_override("margin_top", margin_value)
	
	# Se sobreescribe el tamaño de la fuente normal del textbox:
	textbox_font.add_theme_font_size_override("normal_font_size", textbox_font_size)
	
	# Se sobreescriben los tamaños de fuente de los botones:
	easy_btn.add_theme_font_size_override("font_size", button_font_size)
	medium_btn.add_theme_font_size_override("font_size", button_font_size)
	hard_btn.add_theme_font_size_override("font_size", button_font_size)
	return_btn.add_theme_font_size_override("font_size", button_font_size)
	
	# Se sobreescriben los tamaños de los botones:
	easy_btn.custom_minimum_size = button_size
	medium_btn.custom_minimum_size = button_size
	hard_btn.custom_minimum_size = button_size
	return_btn.custom_minimum_size = return_btn_size
	
	# Se actualiza el último tamaño:
	last_size = DisplayServer.window_get_size()
