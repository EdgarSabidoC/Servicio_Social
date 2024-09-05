extends TabBar

@onready var _str: String = ""
@onready var action_icon: ActionIcon
# Pausa:
@onready var pause_image_path: String
# Mouse:
@onready var left_click_image_path: String

func load_data() -> void:
	# Se crea el ActionIcon:
	action_icon = ActionIcon.new()
	# Se asginan las acciones a los ActionIcon:
	# Teclado:
	action_icon.action_name = "ui_pause"
	pause_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	# Mouse:
	left_click_image_path = action_icon._get_mouse(MOUSE_BUTTON_LEFT).get_path()
	# Se carga la información:
	_str += "[font_size=28]Objetivo[/font_size]
¡Las pizzas se enfrían! Ayuda al mesero robot a entregar las pizzas en las mesas con la coordenada correspondiente. Presta atención al chef, pues él te indicará la coordenada.
Puedes encontrar los controles al final de estas instrucciones.


[font_size=28]Modo contrarreloj[/font_size]
En este modo de juego debes entregar cada pizza lo más rápido posible. ¡Tienes límite de tiempo! Mientras más tiempo pase, menos puntos obtendrás. Si el reloj llega a 0, el juego se termina.


[font_size=28]Modo práctica[/font_size]
En el modo de práctica, no hay puntos ni límite de tiempo. Este modo es ideal para practicar. Tienes todo el tiempo que necesites para asegurarte de que estás aprendiendo bien el sistema de coordenadas.


[font_size=28]Dificultades[/font_size]
A mayor dificultad, mayor puntuación base. Intenta todas las dificultades para dominar el juego.

[font_size=22]Dificultad fácil[/font_size]
Límite de tiempo: 3 minutos

[font_size=22]Dificultad media[/font_size]
Límite de tiempo: 2 minutos

[font_size=22]Dificultad difícil[/font_size]
Límite de tiempo: 1 minuto 30 segundos


[font_size=28]Controles\n\n[/font_size]"
	
	# Clicks del mouse:
	_str += "[font_size=22]Acciones del mouse[/font_size]\n"
	left_click_image_path = "Seleccionar/Mantener: [img={left_click_width}x{left_click_height}]{left_click_image}[/img]\n".format({"left_click_width": 0, "left_click_height": 60, "left_click_image": left_click_image_path})
	_str += left_click_image_path + "\n\n"
	# Pausa:
	_str += "[font_size=22]Teclas de navegación[/font_size]\n" 
	pause_image_path = "[img={pause_width}x{pause_height}]{pause_image}[/img]\n".format({"pause_width": 80, "pause_height": 60, "pause_image": pause_image_path})
	_str += "\n\nMenú de pausa: "
	_str += pause_image_path


func clear_data() -> void:
	action_icon.queue_free()
	_str = ""
	pause_image_path = ""
	left_click_image_path = ""


func _on_visibility_changed() -> void:
	if is_visible():
		load_data()
		$ScrollbarTextbox.print_text(_str)
		return
	clear_data()
