extends Node2D

@onready var clock: Clock = $CanvasLayer/Clock
@onready var pause: Control = $CanvasLayer/Pause
@onready var score_label: Label = $CanvasLayer/ScorePanel/ScoreLabel
@onready var pause_btn: Button = $CanvasLayer/PauseBtn
@onready var ingredients_container: VBoxContainer = $CanvasLayer/IngredientsContainer
@onready var current_pitch: float = 1.0

@onready var l_1: TextureRect = $CanvasLayer/L1
@onready var l_2: TextureRect = $CanvasLayer/L2

@onready var r_1: TextureRect = $CanvasLayer/L1/R1
@onready var r_2: TextureRect = $CanvasLayer/L2/R2

@onready var drop_slot_list: Array[AnimatedTextureRect] = [r_1, r_2]


func _ready() -> void:
	# Se configura el juego:
	self.set_game()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if !self.pause.is_active():
			self.clock.stop()
			self.pause.show()


# Configura el tiempo del reloj:
func set_time() -> void:
	# Se configuran los tiempos del reloj:
	match PlayerSession.difficulty:
		"easy":
			self.clock.time = 240
		"medium":
			self.clock.time = 120
		"hard":
			self.clock.time = 90


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
	self.set_time()
	self.set_ingredients()


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
	BackgroundMusic.stop()
