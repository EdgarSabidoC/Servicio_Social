extends TabBar

@onready var _str: String = ""
@onready var action_icon: ActionIcon
# Navegación:
@onready var up_image_path: String
@onready var down_image_path: String
@onready var left_image_path: String
@onready var right_image_path: String
@onready var pause_image_path: String
# Mouse:
@onready var left_click_image_path: String
@onready var right_click_image_path: String

func load_data() -> void:
	# Se crea el ActionIcon:
	action_icon = ActionIcon.new()
	# Se asginan las acciones a los ActionIcon:
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
	right_click_image_path = action_icon._get_mouse(MOUSE_BUTTON_RIGHT).get_path()
	# Se carga la información:
	_str += "[font_size=28]Objetivo[/font_size]
¡Arma la pizza! Debes lograr armar la pizza de tal forma que ambos lados sean simétricos (simetría con respecto al eje Y). Imagina como si doblaras la pizza por la mitad de forma vertical, cada ingrediente del lado izquierdo debe de coincidir con su respectivo ingrediente del lado derecho. Puedes rotar los ingredientes ya colocados utilizando las teclas de navegación o el click derecho del mouse (ver sección Controles al final de las instrucciones).


[font_size=28]Modo contrarreloj[/font_size]
En este modo de juego, debes armar cada pizza lo más rápido posible. ¡Tienes límite de tiempo! Mientras más tiempo pase, menos puntos obtendrás. Si el reloj llega a 0, el juego se termina.


[font_size=28]Modo práctica[/font_size]
La puntuación y el reloj están desactivados. Este modo es ideal para practicar. Tienes todo el tiempo que necesites para asegurarte de que estás comprendiendo el funcionamiento de la simetría sobre el eje Y.


[font_size=28]Dificultades[/font_size]
Obtén mayor puntuación base subiendo la dificultad del juego. Prueba todas las dificultades e intenta cada vez ser más rápido.

[font_size=22]Dificultad fácil[/font_size]
Límite de tiempo: 1 minuto 30 segundos

[font_size=22]Dificultad media[/font_size]
Límite de tiempo: 2 minutos 30 segundos

[font_size=22]Dificultad difícil[/font_size]
Límite de tiempo: 3 minutos


[font_size=28]Controles\n\n[/font_size]"
	# Teclado:
	_str += "[font_size=22]Teclas de navegación:[/font_size]\n" 
	up_image_path = "Giro completo hacia la derecha: [img={up_width}x{up_height}]{up_image}[/img]\n".format({"up_width": 0, "up_height": 40, "up_image": up_image_path})
	down_image_path = "Giro completo hacia la izquierda: [img={down_width}x{down_height}]{down_image}[/img]\n".format({"down_width": 0, "down_height": 40, "down_image": down_image_path})
	left_image_path = "Medio giro hacia la izquierda: [img={left_width}x{left_height}]{left_image}[/img]\n".format({"left_width": 0, "left_height": 40, "left_image": left_image_path})
	right_image_path = "Medio giro hacia la derecha: [img={right_width}x{right_height}]{right_image}[/img]\n".format({"right_width": 0, "right_height": 40, "right_image": right_image_path})
	_str += up_image_path + down_image_path + left_image_path + right_image_path
	# Pausa:
	pause_image_path = "[img={pause_width}x{pause_height}]{pause_image}[/img]\n".format({"pause_width": 80, "pause_height": 60, "pause_image": pause_image_path})
	_str += "\n\nMenú de pausa: "
	_str += pause_image_path
	# Clicks del mouse:
	_str += "\n\n[font_size=22]Acciones del mouse:[/font_size]\n"
	left_click_image_path = "Seleccionar/Mantener: [img={left_click_width}x{left_click_height}]{left_click_image}[/img]\n".format({"left_click_width": 0, "left_click_height": 60, "left_click_image": left_click_image_path})
	right_click_image_path = "Medio giro hacia la derecha: [img={right_click_width}x{right_click_height}]{right_click_image}[/img]\n".format({"right_click_width": 0, "right_click_height": 60, "right_click_image": right_click_image_path})
	_str += left_click_image_path + right_click_image_path


func clear_data() -> void:
	action_icon.queue_free()
	_str = ""
	up_image_path = ""
	down_image_path = ""
	left_image_path = ""
	right_image_path = ""
	pause_image_path = ""
	left_click_image_path = ""
	right_click_image_path = ""


func _on_visibility_changed() -> void:
	if not is_visible():
		clear_data()
		return
	load_data()
	$ScrollbarTextbox.print_text(_str)
