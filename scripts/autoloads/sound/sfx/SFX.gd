extends AudioStreamPlayer2D

@onready var _key_press_enabled: bool = true

# Enum para los sonidos del juego:
enum Sounds {
	# Pantalla de inicio y otras pantallas donde se tenga que presionar una tecla:
	SPLASH_SCREEN, SCREEN_PRESS, TITLE_SMACK, SCORE_SCREEN,
	# Menús:
	KEY_PRESS, BUTTON_PRESS, BUTTON_REMAP, SLIDER_MOVE, PAUSE_MENU, RESUME_PAUSE,
	# Textos:
	WRITE_TEXT, NEXT_DIALOGUE, CLOSE_DIALOGUE_BOX,
	# Utilidades:
	SCORE, RIGHT_ANSWER, WRONG_ANSWER,
	# Minijuego de fracciones (KITCHEN_BELL es para el botón de aceptar al seleccionar la fracción):
	BUTTON_ACCEPT, BUTTON_REJECT, SHOP_DOORBELL, KITCHEN_BELL,
	# Minijuego de sumas:
	REGISTER_MACHINE, TICKET_PRINT, TAKE_TICKET, REGISTER_BUTTON_PRESS, BILL_SPLAT,
	# Minijuego de coordendas:
	ROBOT_ENTRANCE, ROBOT_HOVER, SERVE_PIZZA, WRITE_ORDER,
	# Minijuego de simetría:
	PIZZA_SPLAT, INGREDIENT_TAKE, INGREDIENT_RELEASE, INGREDIENT_TOP,
	# Sonidos de los personajes:
	CHARACTER_TALK, OPOSSUM_TALK, CHARACTER_CRY, OPOSSUM_SOUND,
	ALUX_ENTRANCE, TOH_ENTRANCE, HUOLPOCH_ENTRANCE, KEKEN_ENTRANCE, ZOTZ_ENTRANCE,
	ALUX_EXIT, TOH_EXIT, HUOLPOCH_EXIT, KEKEN_EXIT, ZOTZ_EXIT
}


# Diccionario que asigna los valores del enum a los streams de audio WAV correspondientes
const _SOUND_PATHS: Dictionary = {
	#Sounds.SPLASH_SCREEN: preload("res://assets/sounds/sfx/splash_screen.wav"),
	Sounds.SCREEN_PRESS: preload("res://assets/sounds/sfx/SCREEN_PRESS.wav"),
	#Sounds.TITLE_SMACK: preload("res://assets/sounds/sfx/title_smack.wav"),
	#Sounds.SCORE_SCREEN: preload("res://assets/sounds/sfx/score_screen.wav"),
	Sounds.KEY_PRESS: preload("res://assets/sounds/sfx/KEY_PRESS.wav"),
	#Sounds.BUTTON_PRESS: preload("res://assets/sounds/sfx/button_press.wav"),
	#Sounds.BUTTON_REMAP: preload("res://assets/sounds/sfx/button_remap.wav"),
	#Sounds.SLIDER_MOVE: preload("res://assets/sounds/sfx/slider_move.wav"),
	#Sounds.PAUSE_MENU: preload("res://assets/sounds/sfx/pause_menu.wav"),
	#Sounds.RESUME_PAUSE: preload("res://assets/sounds/sfx/resume_pause.wav"),
	#Sounds.WRITE_TEXT: preload("res://assets/sounds/sfx/write_text.wav"),
	#Sounds.NEXT_DIALOGUE: preload("res://assets/sounds/sfx/next_dialogue.wav"),
	#Sounds.CLOSE_DIALOGUE_BOX: preload("res://assets/sounds/sfx/close_dialogue_box.wav"),
	#Sounds.SCORE: preload("res://assets/sounds/sfx/score.wav"),
	#Sounds.RIGHT_ANSWER: preload("res://assets/sounds/sfx/right_answer.wav"),
	#Sounds.WRONG_ANSWER: preload("res://assets/sounds/sfx/wrong_answer.wav"),
	#Sounds.BUTTON_ACCEPT: preload("res://assets/sounds/sfx/button_accept.wav"),
	#Sounds.BUTTON_REJECT: preload("res://assets/sounds/sfx/button_reject.wav"),
	#Sounds.SHOP_DOORBELL: preload("res://assets/sounds/sfx/shop_doorbell.wav"),
	#Sounds.KITCHEN_BELL: preload("res://assets/sounds/sfx/kitchen_bell.wav"),
	#Sounds.REGISTER_MACHINE: preload("res://assets/sounds/sfx/register_machine.wav"),
	Sounds.TICKET_PRINT: preload("res://assets/sounds/sfx/TICKET_PRINT.wav"),
	#Sounds.TAKE_TICKET: preload("res://assets/sounds/sfx/take_ticket.wav"),
	#Sounds.REGISTER_BUTTON_PRESS: preload("res://assets/sounds/sfx/register_button_press.wav"),
	#Sounds.BILL_SPLAT: preload("res://assets/sounds/sfx/bill_splat.wav"),
	Sounds.ROBOT_ENTRANCE: preload("res://assets/sounds/sfx/ROBOT_ENTRANCE.wav"),
	Sounds.ROBOT_HOVER: preload("res://assets/sounds/sfx/ROBOT_HOVER.wav"),
	#Sounds.SERVE_PIZZA: preload("res://assets/sounds/sfx/serve_pizza.wav"),
	Sounds.WRITE_ORDER: preload("res://assets/sounds/sfx/WRITE_ORDER.wav"),
	#Sounds.PIZZA_SPLAT: preload("res://assets/sounds/sfx/pizza_splat.wav"),
	#Sounds.INGREDIENT_TAKE: preload("res://assets/sounds/sfx/ingredient_take.wav"),
	#Sounds.INGREDIENT_RELEASE: preload("res://assets/sounds/sfx/ingredient_release.wav"),
	#Sounds.INGREDIENT_TOP: preload("res://assets/sounds/sfx/ingredient_top.wav"),
	#Sounds.CHARACTER_TALK: preload("res://assets/sounds/sfx/character_talk.wav"),
	#Sounds.OPOSSUM_TALK: preload("res://assets/sounds/sfx/opossum_talk.wav"),
	#Sounds.CHARACTER_CRY: preload("res://assets/sounds/sfx/character_cry.wav"),
	#Sounds.OPOSSUM_SOUND: preload("res://assets/sounds/sfx/opossum_sound.wav"),
	#Sounds.ALUX_ENTRANCE: preload("res://assets/sounds/sfx/alux_entrance.wav"),
	#Sounds.TOH_ENTRANCE: preload("res://assets/sounds/sfx/toh_entrance.wav"),
	#Sounds.HUOLPOCH_ENTRANCE: preload("res://assets/sounds/sfx/huolpoch_entrance.wav"),
	#Sounds.KEKEN_ENTRANCE: preload("res://assets/sounds/sfx/keken_entrance.wav"),
	#Sounds.ZOTZ_ENTRANCE: preload("res://assets/sounds/sfx/zotz_entrance.wav"),
	#Sounds.ALUX_EXIT: preload("res://assets/sounds/sfx/alux_exit.wav"),
	#Sounds.TOH_EXIT: preload("res://assets/sounds/sfx/toh_exit.wav"),
	#Sounds.HUOLPOCH_EXIT: preload("res://assets/sounds/sfx/huolpoch_exit.wav"),
	#Sounds.KEKEN_EXIT: preload("res://assets/sounds/sfx/keken_exit.wav"),
	#Sounds.ZOTZ_EXIT: preload("res://assets/sounds/sfx/zotz_exit.wav")
}


# Función que reproduce un sonido
func play_sound(_sound: Sounds, _volume: float = 0.0, _position: float = 0.0, _pitch: float = 1.0) -> void:
	# Se obtiene el sonido:
	var _sound_stream: AudioStreamWAV = _SOUND_PATHS.get(_sound, null)
	# Se verifica que el sonido exista:
	if _sound_stream != null:
		# Se asigna el sonido
		self.stream = _sound_stream
		# Se asigna el volumen
		self.volume_db = _volume
		# Se asigna el pitch_scale (temp y pitch de la canción)
		self.pitch_scale = _pitch
		# Se reproduce en la posición asignada
		self.play(_position)
	else:
		# Si no se encuentra el sonido:
		print_debug("Sound not found for: ", _sound)


# Función que cambia el pitch
func change_pitch(_pitch: float = 1.0) -> void:
	self.pitch_scale = _pitch


# Retorna el valor de _key_press_enabled:
func is_key_press_enabled() -> bool:
	return self._key_press_enabled
