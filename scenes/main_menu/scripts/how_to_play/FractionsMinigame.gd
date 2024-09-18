extends TabBar

@onready var _str: String = ""
@onready var action_icon: ActionIcon 

# Navegación:
@onready var up_image_path: String
@onready var down_image_path: String
@onready var left_image_path: String
@onready var right_image_path: String
# Pausa:
@onready var pause_image_path: String
# Mouse:
@onready var left_click_image_path: String


func load_data() -> void:
	# Se crea el ActionIcon:
	self.action_icon = ActionIcon.new()
	
	# Se obtienen las rutas de las imágenes:
	self.action_icon.action_name = "ui_up"
	up_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	
	self.action_icon.action_name = "ui_down"
	down_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	
	self.action_icon.action_name = "ui_left"
	left_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	
	self.action_icon.action_name = "ui_right"
	right_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	
	self.action_icon.action_name = "ui_pause"
	pause_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	# Mouse:
	self.action_icon.action_name = "m1"
	left_click_image_path = action_icon._get_mouse(MOUSE_BUTTON_LEFT).get_path()
	
	_str = "[font_size=28]Objetivo[/font_size]
¡El cliente siempre tiene la razón! Los diferentes amigos y clientes de nuestra querida amiga zarigüeya entrarán y te ordenarán sus pizzas favoritas. Presta atención a los detalles, pues te pedirán fracciones o números de rebanadas, así como la cantidad de bebidas y órdenes de pan. No querrás decepcionarlos, así que selecciona las opciones correctas.
Puedes checar los controles al final de las instrucciones.


[font_size=28]Contrarreloj[/font_size]
En este modo de juego debes resolver cada problema lo más rápido posible. No hay límite de tiempo, pero debes estar atento porque mientras más tiempo tardes en resolver cada problema, menos puntos obtendrás.


[font_size=28]Multiplicadores de personaje[/font_size]
Gana los multiplicadores de personaje para ganar un bonus sobre los puntos que obtienes. Para ello es necesario aceptar la orden del respectivo personaje y vender la orden correcta.


[font_size=28]Dificultades[/font_size]
A mayor dificultad, mayores serán las oportunidades de obtener puntajes más altos, así que no tengas miedo de probar cada una de ellas.

[font_size=22]Dificultad fácil[/font_size]
El objetivo es encontrar la fracción de pizza correcta que corresponde al problema que se te presenta. Los problemas se pueden presentar directamente como fracciones.

[font_size=22]Dificultad media[/font_size]
El objetivo es encontrar la fracción de pizza correcta que corresponde al problema que se te presenta. Los problemas se pueden presentar directamente como fracciones, además tienes que hallar la proporción correcta de panes con respecto a las bebidas.

[font_size=22]Dificultad difícil[/font_size]
El objetivo es encontrar la fracción de pizza correcta que corresponde al problema que se te presenta. Los problemas se pueden presentar directamente como fracciones o cantidad de rebanadas, además tienes que hallar la proporción correcta de panes con respecto a las bebidas.


[font_size=28]Controles\n\n[/font_size]"

	# Se carga la información:
	# Teclado:
	_str += "[font_size=22]Teclas de navegación[/font_size]\n" 
	up_image_path = "Arriba: [img={up_width}x{up_height}]{up_image}[/img]\n".format({"up_width": 0, "up_height": 40, "up_image": up_image_path})
	down_image_path = "Abajo: [img={down_width}x{down_height}]{down_image}[/img]\n".format({"down_width": 0, "down_height": 40, "down_image": down_image_path})
	left_image_path = "Izquierda: [img={left_width}x{left_height}]{left_image}[/img]\n".format({"left_width": 0, "left_height": 40, "left_image": left_image_path})
	right_image_path = "Derecha: [img={right_width}x{right_height}]{right_image}[/img]\n".format({"right_width": 0, "right_height": 40, "right_image": right_image_path})
	_str += up_image_path + down_image_path + left_image_path + right_image_path
	# Pausa:
	pause_image_path = "[img={pause_width}x{pause_height}]{pause_image}[/img]\n".format({"pause_width": 80, "pause_height": 60, "pause_image": pause_image_path})
	_str += "\n\nMenú de pausa: "
	_str += pause_image_path
	# Clicks del mouse:
	_str += "\n\n[font_size=22]Acciones del mouse[/font_size]\n"
	left_click_image_path = "Seleccionar: [img={left_click_width}x{left_click_height}]{left_click_image}[/img]\n".format({"left_click_width": 0, "left_click_height": 60, "left_click_image": left_click_image_path})
	_str += left_click_image_path


func clear_data() -> void:
	action_icon.queue_free()
	_str = ""
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
