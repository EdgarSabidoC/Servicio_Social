extends TabBar

@onready var _str: String = ""
@onready var action_icon: ActionIcon
# Teclado numérico:
@onready var key_0_image_path: String
@onready var key_1_image_path: String
@onready var key_2_image_path: String
@onready var key_3_image_path: String
@onready var key_4_image_path: String
@onready var key_5_image_path: String
@onready var key_6_image_path: String
@onready var key_7_image_path: String
@onready var key_8_image_path: String
@onready var key_9_image_path: String
@onready var key_period_image_path: String
@onready var key_backspace_image_path: String
# Navegación:
@onready var up_image_path: String
@onready var down_image_path: String
@onready var left_image_path: String
@onready var right_image_path: String
@onready var pause_image_path: String
# Mouse:
@onready var left_click_image_path: String

func load_data() -> void:
	# Se crea el ActionIcon:
	action_icon = ActionIcon.new()
	
	# Se obtienen las rutas de las imágenes:
	# Teclado numérico:
	key_0_image_path = action_icon._get_keyboard(KEY_0).get_path()
	key_1_image_path = action_icon._get_keyboard(KEY_1).get_path()
	key_2_image_path = action_icon._get_keyboard(KEY_2).get_path()
	key_3_image_path = action_icon._get_keyboard(KEY_3).get_path()
	key_4_image_path = action_icon._get_keyboard(KEY_4).get_path()
	key_5_image_path = action_icon._get_keyboard(KEY_5).get_path()
	key_6_image_path = action_icon._get_keyboard(KEY_6).get_path()
	key_7_image_path = action_icon._get_keyboard(KEY_7).get_path()
	key_8_image_path = action_icon._get_keyboard(KEY_8).get_path()
	key_9_image_path = action_icon._get_keyboard(KEY_9).get_path()
	key_period_image_path = "res://addons/ActionIcon/Keyboard/Period.png"
	key_backspace_image_path = action_icon._get_keyboard(KEY_BACKSPACE).get_path()
	# Teclado:
	action_icon.action_name = "ui_up"
	up_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	action_icon.action_name = "ui_down"
	down_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	action_icon.action_name = "ui_left"
	left_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	action_icon.action_name = "ui_right"
	right_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	action_icon.action_name = "ui_pause"
	pause_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	# Mouse:
	left_click_image_path = action_icon._get_mouse(MOUSE_BUTTON_LEFT).get_path()
	
	# Se carga la información:
	_str = "[font_size=28]Objetivo[/font_size]
¡El momento ha llegado! Después de que nuestros queridos clientes han llenado sus panzas con nuestras deliciosas pizzas llega el momento de cobrarles, pero lamentablemente la caja registradora está fallando y sólo te permite ingresar el monto total de la cuenta. Realiza la sumas y multiplicaciones para hallar el total de la cuenta de cada cliente e ingrésalo en la caja registradora. ¡Te sugerimos tener a mano una libreta donde puedas apuntar los precios y realizar tus operaciones! Si lo necesitas puedes checar la lista de precios en todo momento.
Los controles se encuentran al final de las instrucciones.


[font_size=28]Modo contrarreloj[/font_size]
En este modo de juego debes cobrar cada cuenta lo más rápido posible. ¡Tienes límite de tiempo! Mientras más tiempo pase, menos puntos obtendrás. Si el reloj llega a 0, el juego se termina.


[font_size=28]Modo práctica[/font_size]
En el modo de práctica, no hay puntos ni límite de tiempo. Este modo es ideal para que puedas practicar las sumas y multiplicaciones sin preocuparte por cometer errores. Tienes todo el tiempo que necesites para asegurarte de que estás aprendiendo bien cómo sumar y multiplicar. Presta atención a los mensajes, ellos te indicarán si has resuelto correctamente los problemas.


[font_size=28]Dificultades[/font_size]
No temas intentar mayores dificultades, pues mientras más grande es el desafío, mejores son las recompensas.

[font_size=22]Dificultad fácil[/font_size]
Límite de tiempo: 3 minutos

[font_size=22]Dificultad media[/font_size]
Límite de tiempo: 4 minutos

[font_size=22]Dificultad difícil[/font_size]
Límite de tiempo: 5 minutos


[font_size=28]Controles\n\n[/font_size]"
	
	# Teclado numérico:
	_str += "[font_size=22]Teclas numéricas[/font_size]\n"
	key_0_image_path = "[img={key_0_width}x{key_0_height}]{key_0_image}[/img]".format({"key_0_width": 0, "key_0_height": 40, "key_0_image": key_0_image_path})
	key_1_image_path = "[img={key_1_width}x{key_1_height}]{key_1_image}[/img]".format({"key_1_width": 0, "key_1_height": 40, "key_1_image": key_1_image_path})
	key_2_image_path = "[img={key_2_width}x{key_2_height}]{key_2_image}[/img]".format({"key_2_width": 0, "key_2_height": 40, "key_2_image": key_2_image_path})
	key_3_image_path = "[img={key_3_width}x{key_3_height}]{key_3_image}[/img]".format({"key_3_width": 0, "key_3_height": 40, "key_3_image": key_3_image_path})
	key_4_image_path = "[img={key_4_width}x{key_4_height}]{key_4_image}[/img]".format({"key_4_width": 0, "key_4_height": 40, "key_4_image": key_4_image_path})
	key_5_image_path = "[img={key_5_width}x{key_5_height}]{key_5_image}[/img]".format({"key_5_width": 0, "key_5_height": 40, "key_5_image": key_5_image_path})
	key_6_image_path = "[img={key_6_width}x{key_6_height}]{key_6_image}[/img]".format({"key_6_width": 0, "key_6_height": 40, "key_6_image": key_6_image_path})
	key_7_image_path = "[img={key_7_width}x{key_7_height}]{key_7_image}[/img]".format({"key_7_width": 0, "key_7_height": 40, "key_7_image": key_7_image_path})
	key_8_image_path = "[img={key_8_width}x{key_8_height}]{key_8_image}[/img]".format({"key_8_width": 0, "key_8_height": 40, "key_8_image": key_8_image_path})
	key_9_image_path = "[img={key_9_width}x{key_9_height}]{key_9_image}[/img]".format({"key_9_width": 0, "key_9_height": 40, "key_9_image": key_9_image_path})
	key_period_image_path = "[img={key_period_width}x{key_period_height}]{key_period_image}[/img]".format({"key_period_width": 0, "key_period_height": 40, "key_period_image": key_period_image_path})
	key_backspace_image_path = "Borrar: [img={key_backspace_width}x{key_backspace_height}]{key_backspace_image}[/img]\n".format({"key_backspace_width": 80, "key_backspace_height": 60, "key_backspace_image": key_backspace_image_path})
	_str += key_7_image_path + key_8_image_path + key_9_image_path + "\n" + key_4_image_path + key_5_image_path + key_6_image_path + "\n" + key_1_image_path + key_2_image_path + key_3_image_path + "\n" + key_0_image_path + key_period_image_path + "\n" + key_backspace_image_path
	# Clicks del mouse:
	_str += "\n\n[font_size=22]Acciones del mouse[/font_size]\n"
	left_click_image_path = "Seleccionar/Presionar botones de la registradora: [img={left_click_width}x{left_click_height}]{left_click_image}[/img]\n".format({"left_click_width": 0, "left_click_height": 60, "left_click_image": left_click_image_path})
	_str += left_click_image_path
	# Teclado:
	_str += "\n\n[font_size=22]Teclas de navegación[/font_size]\n" 
	up_image_path = "Arriba: [img={up_width}x{up_height}]{up_image}[/img]\n".format({"up_width": 0, "up_height": 40, "up_image": up_image_path})
	down_image_path = "Abajo: [img={down_width}x{down_height}]{down_image}[/img]\n".format({"down_width": 0, "down_height": 40, "down_image": down_image_path})
	left_image_path = "Izquierda: [img={left_width}x{left_height}]{left_image}[/img]\n".format({"left_width": 0, "left_height": 40, "left_image": left_image_path})
	right_image_path = "Derecha: [img={right_width}x{right_height}]{right_image}[/img]\n".format({"right_width": 0, "right_height": 40, "right_image": right_image_path})
	_str += up_image_path + down_image_path + left_image_path + right_image_path
	# Pausa:
	pause_image_path = "[img={pause_width}x{pause_height}]{pause_image}[/img]\n".format({"pause_width": 80, "pause_height": 60, "pause_image": pause_image_path})
	_str += "\n\nMenú de pausa: "
	_str += pause_image_path


func clear_data() -> void:
	action_icon.queue_free()
	_str = ""
	key_0_image_path = ""
	key_1_image_path = ""
	key_2_image_path = ""
	key_3_image_path = ""
	key_4_image_path = ""
	key_5_image_path = ""
	key_6_image_path = ""
	key_7_image_path = ""
	key_8_image_path = ""
	key_9_image_path = ""
	key_period_image_path = ""
	key_backspace_image_path = ""
	up_image_path = ""
	down_image_path = ""
	left_image_path = ""
	right_image_path = ""
	pause_image_path = ""
	left_click_image_path = ""


func _on_visibility_changed() -> void:
	if not is_visible():
		clear_data()
		return
	load_data()
	$ScrollbarTextbox.print_text(_str)
