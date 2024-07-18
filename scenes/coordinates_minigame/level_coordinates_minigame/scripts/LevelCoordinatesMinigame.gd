extends Node2D

@onready var pause: Control = $CanvasLayer/Pause
@onready var clock: Clock = $CanvasLayer/Clock
@onready var score_label: Label = $CanvasLayer/ScorePanel/ScoreLabel

# Tiempos del reloj por dificultad:
## Time for clock on easy difficulty.
@export var time_easy: float = 180
## Time for clock on medium difficulty.
@export var time_medium: float = 120
## Time for clock on hard difficulty.
@export var time_hard: float = 90

## Default score.
@onready var default_score: int = 10000

# Animación de la zarigüeya:
@onready var animated_texture_rect: AnimatedTextureRect = $CanvasLayer/AnimatedTextureRect

@onready var current_pitch: float


func _enter_tree() -> void:
	# Se configura la música:
	self.set_music()


func _ready() -> void:
	# Se configura el juego/partida:
	self.set_game()
	self.animated_texture_rect.play()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if !self.pause.is_active():
			self.clock.stop()
			self.pause.show()


# Reduce el puntaje predeterminado:
func reduce_default_score() -> void:
	self.default_score -= 1250


# Otorga un puntaje basándose en el tiempo:
func set_score() -> void:
	PlayerSession.score += self.default_score


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
	
	# Se reinicia el puntaje por predeterminado:
	self.default_score = 10000
	
	# Se imprime el puntaje:
	self.score_label.print_score()
	
	# Se genera una coordenada:
	self.set_order_coordinates()
	
	# Se configuran el tiempo y los ingredientes:
	self.set_clock()
	
	# Contiúa el reloj:
	self.clock.continue_clock()


# Genera un par de coordenadas aleatorias:
func set_order_coordinates() -> void:
	%Robot.set_rand_coordinates()


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
	
	# Se reduce el puntaje por defecto:
	self.reduce_default_score()


func _on_clock_countdown_finished() -> void:
	# Se reinicia el pitch de la canción:
	BackgroundMusic.change_pitch(1.0)
	
	# Se muestra la pantalla de puntajes:
	self.score_screen.show()
	self.score_screen.print_score()


func _on_score_screen_restart_game() -> void:
	# Se configura el juego/partida:
	self.set_game()
