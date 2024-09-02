extends Control

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var texture_rect: TextureRect = $TextureRect
@onready var dialogue_box: Control = $DialogueBox

@onready var fractions_text: String = "[StartParagraph]El juego consiste en encontrar la fracción de pizza correspondiente al problema.\n
En dificultades media y difícil también es necesario hallar la proporción correcta de bebidas y órdenes de pan.
[StartParagraph]Completa las órdenes en el menor tiempo para conseguir más puntos."
@onready var additions_text: String = "[StartParagraph]El juego consiste en realizar la suma correcta presentada en la nota de venta e ingresar solo el resultado en la caja registradora.[StartParagraph]Puedes usar el teclado para ingresar o eliminar los números y punto.\n
También puedes presionar los botones de la registradora con el click izquierdo del mouse."
@onready var coordinates_text: String = "[StartParagraph]El juego consiste en repartir las pizzas en la mesa con la coordenada correspondiente.
[StartParagraph]Presiona [LEFTCLICK] y mientras lo mantienes arrastra al ayudante robot con el mouse hasta la respectiva mesa y luego suelta [LEFTCLICK] para dejar caer la pizza."
@onready var symmetry_text: String = "[StartParagraph]El juego consiste en colocar los ingredientes correspondientes en el lado derecho y girarlos para hacer que la pizza quede simétrica con respecto al eje Y.[StartParagraph]Utiliza [LEFTCLICK] sobre la tabla de ingredientes del lado derecho, manténlo presionado y arrastra los ingredientes sobre los espacios con el mouse, luego suelta [LEFTCLICK] para colocarlo.[StartParagraph]Haz que giren los ingredientes utilizando los botones de navegación [UP], [DOWN], [LEFT], [RIGHT] mientras tienes el puntero del ratón/mouse encima del ingrediente o utiliza [RIGHTCLICK]."

# ACTION ICONS
@onready var action_icon: ActionIcon
# Navegación:
@onready var up_image_path: String
@onready var down_image_path: String
@onready var left_image_path: String
@onready var right_image_path: String
# Mouse:
@onready var left_click_image_path: String
@onready var right_click_image_path: String

# Tamaños de teclas de navegación:
@export var up_width: float = 0
@export var up_height: float = 80
@export var down_width: float = 0
@export var down_height: float = 80
@export var left_width: float = 0
@export var left_height: float = 80
@export var right_width: float = 0
@export var right_height: float = 80
# Tamaño de botones de mouse:
@export var left_click_width: float = 0
@export var left_click_height: float = 60
@export var right_click_width: float = 0
@export var right_click_height: float = 60

## Finished signal is emitted when the info screen finishes.
signal finished


func start() -> void:
	Sfx.play_sound(Sfx.Sounds.INFO_SCREEN, 20)
	self.show()
	self.animated_sprite_2d.play()
	
	# Se crea el ActionIcon:
	action_icon = ActionIcon.new()
	# Se asginan las acciones a los ActionIcon:
	# Teclas de navegación:
	action_icon.action_name = "ui_up"
	up_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	action_icon.action_name = "ui_down"
	down_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	action_icon.action_name = "ui_left"
	left_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	action_icon.action_name = "ui_right"
	right_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	# Clicks izquierdo y derecho
	left_click_image_path = action_icon._get_mouse(MOUSE_BUTTON_LEFT).get_path()
	right_click_image_path = action_icon._get_mouse(MOUSE_BUTTON_RIGHT).get_path()
	
	up_image_path = "«[img={up_width}x{up_height}]{up_image}[/img]»".format({"up_width": 0, "up_height": 40, "up_image": up_image_path})
	down_image_path = "«[img={down_width}x{down_height}]{down_image}[/img]»".format({"down_width": 0, "down_height": 40, "down_image": down_image_path})
	left_image_path = "«[img={left_width}x{left_height}]{left_image}[/img]»".format({"left_width": 0, "left_height": 40, "left_image": left_image_path})
	right_image_path = "«[img={right_width}x{right_height}]{right_image}[/img]»".format({"right_width": 0, "right_height": 40, "right_image": right_image_path})
	left_click_image_path = "«[img={left_click_width}x{left_click_height}]{left_click_image}[/img]»".format({"left_click_width": 0, "left_click_height": 40, "left_click_image": left_click_image_path})
	right_click_image_path = "«[img={right_click_width}x{right_click_height}]{right_click_image}[/img]»".format({"right_click_width": 0, "right_click_height": 40, "right_click_image": right_click_image_path})
	
	# Se carga el texto correspondiente al minijuego:
	match PlayerSession.current_minigame:
		PlayerSession.Minigames.FRACCTIONS:
			PlayerSession.fractions_info_screen = true
			self.dialogue_box.load_message(self.fractions_text)
		PlayerSession.Minigames.ADDITIONS:
			if PlayerSession.is_practice_mode():
				self.additions_text += "[StartParagraph]En el modo práctica no se adquieren puntos.\n\n[b]Modo contrareloj desactivado.[/b]"
			else: 
				self.additions_text += "[StartParagraph][b]Contrareloj activado:[/b] Mientras más tiempo pase, menos puntos obtendrás, así que sé lo más rápido que puedas."
			PlayerSession.additions_info_screen = true
			self.dialogue_box.load_message(self.additions_text)
		PlayerSession.Minigames.COORDINATES:
			self.coordinates_text = self.coordinates_text.replace("[LEFTCLICK]", left_click_image_path)
			if PlayerSession.is_practice_mode():
				self.coordinates_text += "[StartParagraph]En el modo práctica no se adquieren puntos.\n\n[b]Modo contrareloj desactivado.[/b]"
			else: 
				self.coordinates_text += "[StartParagraph][b]Contrareloj activado:[/b] Mientras más tiempo pase, menos puntos obtendrás, así que sé lo más rápido que puedas."
			PlayerSession.coordinates_info_screen = true
			self.dialogue_box.load_message(self.coordinates_text)
		PlayerSession.Minigames.SYMMETRY:
			self.symmetry_text = self.symmetry_text.replace("[UP]", up_image_path)
			self.symmetry_text = self.symmetry_text.replace("[DOWN]", down_image_path)
			self.symmetry_text = self.symmetry_text.replace("[LEFT]", left_image_path)
			self.symmetry_text = self.symmetry_text.replace("[RIGHT]", right_image_path)
			self.symmetry_text = self.symmetry_text.replace("[LEFTCLICK]", left_click_image_path)
			self.symmetry_text = self.symmetry_text.replace("[RIGHTCLICK]", right_click_image_path)
			if PlayerSession.is_practice_mode():
				self.symmetry_text += "[StartParagraph]En el modo práctica no se adquieren puntos.\n\n[b]Modo contrareloj desactivado.[/b]"
			else: 
				self.symmetry_text += "[StartParagraph][b]Contrareloj activado:[/b] Mientras más tiempo pase, menos puntos obtendrás, así que sé lo más rápido que puedas."
			PlayerSession.symmetry_info_screen = true
			self.dialogue_box.load_message(self.symmetry_text)
	self.dialogue_box.start()


func _on_dialogue_box_dialogue_box_closed() -> void:
	self.finished.emit()
	if !PlayerSession.destroy_info_screen():
		self.hide()
	else:
		self.queue_free()
