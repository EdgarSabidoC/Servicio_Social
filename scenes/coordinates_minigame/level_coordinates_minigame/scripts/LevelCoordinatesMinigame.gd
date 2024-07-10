extends Node2D

@onready var pause: Control = $CanvasLayer/Pause
@onready var clock: Clock = $CanvasLayer/Clock
@onready var score_label: Label = $CanvasLayer/ScorePanel/ScoreLabel

# Tiempos del reloj por dificultad:
@export var time_easy: float = 180
@export var time_medium: float = 120
@export var time_hard: float = 90


func _enter_tree() -> void:
	# Se configura la música:
	self.set_music()


func _ready() -> void:
	# Se configura el juego/partida:
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


# Configura la partida:
func set_game() -> void:	
	# Se inicializa el puntaje en 0:
	PlayerSession.score = 0
	
	# Se imprime el puntaje:
	self.score_label.print_score()
	
	# Se configuran el tiempo y los ingredientes:
	self.set_clock()


func _on_pause_finished() -> void:
	if !Mouse.mouse_mode_activated:
		pass
	self.clock.continue_clock()
	self.pause.hide()


func _on_pause_btn_pressed() -> void:
	if !self.pause.is_active():
			self.clock.stop()
			self.pause.show()


# Cuando se llegue a un pivote en cuenta atrás se aumenta la velocidad de la música:
func _on_clock_pivot_changed() -> void:
	# Se aumenta el pitch_scale de la música por cada minuto de juego:
	self.current_pitch += 0.1
	BackgroundMusic.change_pitch(self.current_pitch)
