extends AudioStreamPlayer2D

@onready var _key_press_enabled: bool = true

# Enum para los sonidos del juego:
enum Sounds {
	# Pantalla de inicio y otras pantallas donde se tenga que presionar una tecla:
	SPLASH_SCREEN, SCREEN_PRESS, TITLE_SMACK, SCORE_SCREEN, INFO_SCREEN,
	# Menús:
	KEY_PRESS, BUTTON_REMAP, SLIDER_MOVE, PAUSE_MENU, RESUME_PAUSE,
	# Textos:
	WRITE_TEXT, NEXT_DIALOGUE, OPEN_DIALOGUE_BOX, CLOSE_DIALOGUE_BOX,
	# Utilidades:
	SCORE, RIGHT_ANSWER, WRONG_ANSWER,
	# Minijuego de fracciones (SERVICE_BELL es para el botón de aceptar al seleccionar la fracción):
	BUTTON_ACCEPT, BUTTON_REJECT, SHOP_DOORBELL, SERVICE_BELL,
	# Minijuego de sumas:
	REGISTER_MACHINE, TICKET_PRINT, TAKE_TICKET, REGISTER_BUTTON_PRESS, BILL,
	# Minijuego de coordendas:
	ROBOT_ENTRANCE, ROBOT_HOVER, SERVE_PIZZA, WRITE_ORDER,
	# Minijuego de simetría:
	PIZZA_SPLAT, INGREDIENT_TAKE, INGREDIENT_RELEASE, INGREDIENT_TOP,
	# Sonidos de los personajes:
	CHARACTER_CRY_MALE_1, CHARACTER_CRY_MALE_2, CHARACTER_CRY_FEMALE,ALUX_ENTRANCE,
	TOH_ENTRANCE, HUOLPOCH_ENTRANCE, KEKEN_ENTRANCE, ZOTZ_ENTRANCE, ALUX_EXIT,
	CHARACTER_EXIT, CHARACTER_EXIT_FAILURE
}


# Diccionario que asigna los valores del enum a los streams de audio WAV correspondientes
const _SOUND_PATHS: Dictionary = {
	Sounds.SPLASH_SCREEN: preload("res://assets/sounds/sfx/SPLASH_SCREEN.wav"),
	Sounds.SCREEN_PRESS: preload("res://assets/sounds/sfx/SCREEN_PRESS.wav"),
	Sounds.TITLE_SMACK: preload("res://assets/sounds/sfx/TITLE_SMACK.wav"),
	Sounds.SCORE_SCREEN: preload("res://assets/sounds/sfx/SCORE_SCREEN.wav"),
	Sounds.INFO_SCREEN: preload("res://assets/sounds/sfx/INFO_SCREEN.wav"),
	Sounds.KEY_PRESS: preload("res://assets/sounds/sfx/KEY_PRESS.wav"),
	Sounds.BUTTON_REMAP: preload("res://assets/sounds/sfx/BUTTON_REMAP.wav"),
	Sounds.SLIDER_MOVE: preload("res://assets/sounds/sfx/SLIDER_MOVE.wav"),
	Sounds.PAUSE_MENU: preload("res://assets/sounds/sfx/PAUSE_MENU.wav"),
	Sounds.RESUME_PAUSE: preload("res://assets/sounds/sfx/RESUME_PAUSE.wav"),
	Sounds.WRITE_TEXT: preload("res://assets/sounds/sfx/WRITE_TEXT.wav"),
	Sounds.NEXT_DIALOGUE: preload("res://assets/sounds/sfx/NEXT_DIALOGUE.wav"),
	Sounds.OPEN_DIALOGUE_BOX: preload("res://assets/sounds/sfx/OPEN_DIALOGUE_BOX.wav"),
	Sounds.CLOSE_DIALOGUE_BOX: preload("res://assets/sounds/sfx/CLOSE_DIALOGUE_BOX.wav"),
	Sounds.SCORE: preload("res://assets/sounds/sfx/SCORE.wav"),
	Sounds.RIGHT_ANSWER: preload("res://assets/sounds/sfx/RIGHT_ANSWER.wav"),
	Sounds.WRONG_ANSWER: preload("res://assets/sounds/sfx/WRONG_ANSWER.wav"),
	Sounds.BUTTON_ACCEPT: preload("res://assets/sounds/sfx/BUTTON_ACCEPT.wav"),
	Sounds.BUTTON_REJECT: preload("res://assets/sounds/sfx/BUTTON_REJECT.wav"),
	Sounds.SHOP_DOORBELL: preload("res://assets/sounds/sfx/SHOP_DOORBELL.wav"),
	Sounds.SERVICE_BELL: preload("res://assets/sounds/sfx/SERVICE_BELL.wav"),
	Sounds.REGISTER_MACHINE: preload("res://assets/sounds/sfx/REGISTER_MACHINE.wav"),
	Sounds.TICKET_PRINT: preload("res://assets/sounds/sfx/TICKET_PRINT.wav"),
	Sounds.TAKE_TICKET: preload("res://assets/sounds/sfx/TAKE_TICKET.wav"),
	Sounds.REGISTER_BUTTON_PRESS: preload("res://assets/sounds/sfx/REGISTER_BUTTON_PRESS.wav"),
	Sounds.BILL: preload("res://assets/sounds/sfx/BILL.wav"),
	Sounds.ROBOT_ENTRANCE: preload("res://assets/sounds/sfx/ROBOT_ENTRANCE.wav"),
	Sounds.ROBOT_HOVER: preload("res://assets/sounds/sfx/ROBOT_HOVER.wav"),
	Sounds.SERVE_PIZZA: preload("res://assets/sounds/sfx/SERVE_PIZZA.wav"),
	Sounds.WRITE_ORDER: preload("res://assets/sounds/sfx/WRITE_ORDER.wav"),
	Sounds.PIZZA_SPLAT: preload("res://assets/sounds/sfx/PIZZA_SPLAT.wav"),
	Sounds.INGREDIENT_TAKE: preload("res://assets/sounds/sfx/INGREDIENT_TAKE.wav"),
	Sounds.INGREDIENT_RELEASE: preload("res://assets/sounds/sfx/INGREDIENT_RELEASE.wav"),
	Sounds.INGREDIENT_TOP: preload("res://assets/sounds/sfx/INGREDIENT_TOP.wav"),
	Sounds.CHARACTER_CRY_MALE_1: preload("res://assets/sounds/sfx/CHARACTER_CRY_MALE_1.wav"),
	Sounds.CHARACTER_CRY_MALE_2: preload("res://assets/sounds/sfx/CHARACTER_CRY_MALE_2.wav"),
	Sounds.CHARACTER_CRY_FEMALE: preload("res://assets/sounds/sfx/CHARACTER_CRY_FEMALE.wav"),
	Sounds.ALUX_ENTRANCE: preload("res://assets/sounds/sfx/ALUX_ENTRANCE.wav"),
	Sounds.TOH_ENTRANCE: preload("res://assets/sounds/sfx/TOH_ENTRANCE.wav"),
	Sounds.HUOLPOCH_ENTRANCE: preload("res://assets/sounds/sfx/HUOLPOCH_ENTRANCE.wav"),
	Sounds.KEKEN_ENTRANCE: preload("res://assets/sounds/sfx/KEKEN_ENTRANCE.wav"),
	Sounds.ZOTZ_ENTRANCE: preload("res://assets/sounds/sfx/ZOTZ_ENTRANCE.wav"),
	Sounds.ALUX_EXIT: preload("res://assets/sounds/sfx/ALUX_EXIT.wav"),
	Sounds.CHARACTER_EXIT: preload("res://assets/sounds/sfx/CHARACTER_EXIT.wav"),
	Sounds.CHARACTER_EXIT_FAILURE: preload("res://assets/sounds/sfx/CHARACTER_EXIT_FAILURE.wav"),
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
