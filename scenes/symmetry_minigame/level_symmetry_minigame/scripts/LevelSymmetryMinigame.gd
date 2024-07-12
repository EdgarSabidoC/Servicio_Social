extends Node2D

@onready var clock: Clock = $CanvasLayer/Clock
@onready var pause: Control = $CanvasLayer/Pause
@onready var score_label: Label = $CanvasLayer/ScorePanel/ScoreLabel
@onready var pause_btn: Button = $CanvasLayer/PauseBtn
@onready var ingredients_container: VBoxContainer = $CanvasLayer/IngredientsContainer
@onready var current_pitch: float = 1.0
@onready var score_screen: Control = $CanvasLayer/ScoreScreen

# Tiempos del reloj por dificultad:
@export var time_easy: float = 180
@export var time_medium: float = 120
@export var time_hard: float = 90

@onready var l_1: TextureRect = $CanvasLayer/L1
@onready var l_2: TextureRect = $CanvasLayer/L2
@onready var r_1: TextureRect = $CanvasLayer/R1
@onready var r_2: TextureRect = $CanvasLayer/R2

@onready var drop_slot_list: Array[AnimatedTextureRect] = [r_1, r_2]


func _enter_tree() -> void:
	# Se configura la música:
	self.set_music()


func _ready() -> void:
	# Se configura el juego:
	self.set_game()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if !self.pause.is_active():
			self.clock.stop()
			self.pause.show()


# Configura la música de fondo:
func set_music() -> void:
	# Se cambia la música:
	var current_position: float = 0
	var volume: float = 0
	BackgroundMusic.start_minigame_song(volume, current_position)


# Configura el tiempo del reloj:
func set_clock() -> void:
	match PlayerSession.difficulty:
		"easy":
			self.clock.time = self.time_easy
		"medium":
			self.clock.time = self.time_medium
		"hard":
			self.clock.time = self.time_hard


func set_ingredients():
	# Se generan los ingredientes aleatorios:
	self.l_1.generate_rand_ingredient()
	self.l_2.generate_rand_ingredient()
	#self.l_3.generate_rand_ingredient()
	#self.l_4.generate_rand_ingredient()
	#self.l_5.generate_rand_ingredient()
	#self.l_6.generate_rand_ingredient()
	#self.l_7.generate_rand_ingredient()
	#self.l_8.generate_rand_ingredient()


# Configura la partida:
func set_game() -> void:	
	# Se inicializa el puntaje en 0:
	PlayerSession.score = 0
	
	# Se imprime el puntaje:
	self.score_label.print_score()
	
	# Se configuran el tiempo y los ingredientes:
	self.set_clock()
	self.set_ingredients()
	
	# Contiúa el reloj:
	self.clock.continue_clock()


func _on_pause_finished() -> void:
	if !Mouse.mouse_mode_activated:
		pass
	self.clock.continue_clock()
	self.pause.hide()


func _on_reset_pressed() -> void:
	for slot in self.drop_slot_list:
		if slot.texture:
			slot.clear_data()


func _on_r_1_data_dropped() -> void:
	if self.l_1.ingredient_name == self.r_1.ingredient_name:
		print_debug("Son iguales %s -> %s" %[self.l_1.get_ingredient_name(), self.r_1.get_ingredient_name()])


func _on_pause_btn_pressed() -> void:
	if !self.pause.is_active():
		if !Mouse.mouse_mode_activated:
			self.pause.continue_btn.grab_focus()
		else:
			self.pause_btn.release_focus()
		self.clock.stop()
		self.pause.show()


# Cuando se llegue a un pivote en cuenta atrás se aumenta la velocidad de la música:
func _on_clock_pivot_changed() -> void:
	# Se aumenta el pitch_scale de la música por cada minuto de juego:
	self.current_pitch += 0.1
	BackgroundMusic.change_pitch(self.current_pitch)


func _on_clock_countdown_finished() -> void:
	# Se reinicia el pitch de la canción:
	BackgroundMusic.change_pitch(1.0)
	
	# Se muestra la pantalla de puntajes:
	self.score_screen.show()
	self.score_screen.print_score()


func _on_score_screen_restart_game() -> void:
	# Se configura el juego/partida:
	self.set_game()
