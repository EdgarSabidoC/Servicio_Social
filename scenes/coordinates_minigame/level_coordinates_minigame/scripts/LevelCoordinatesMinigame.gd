extends Node2D

@onready var pause: Control = $CanvasLayer/Pause
@onready var clock: Clock = $CanvasLayer/Clock
@onready var score_label: Label = $CanvasLayer/ScorePanel/ScoreLabel
@onready var label: Label = $CanvasLayer/AnimatedTextureRect/Label
@onready var score_screen: Control = $CanvasLayer/ScoreScreen
@onready var score_panel: Panel = $CanvasLayer/ScorePanel
@onready var score_flash_label: Label = $CanvasLayer/ScoreFlashLabel
@onready var score_label_player: AnimationPlayer = $CanvasLayer/ScoreFlashLabel/AnimationPlayer


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
@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimatedTextureRect/AnimationPlayer

@onready var current_pitch: float = 1.0


func _enter_tree() -> void:
	# Se configura la música:
	self.set_music()


func _ready() -> void:
	# Se configura el juego/partida:
	self.set_game()
	self.connect_signals()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if !self.pause.is_active():
			self.clock.stop()
			self.pause.show()


func connect_signals() -> void:
	var tables: Array = [%Table1, %Table2, %Table3, \
						%Table4, %Table5, %Table6, \
						%Table7, %Table8, %Table9]
	
	for table in tables:
		table.data_dropped.connect(func() -> void: self.check_answer(table, %Robot))
		table.timer_ended.connect(func() -> void: self.set_order_coordinates())


# Verifica que la respuesta sea correcta:
func check_answer(table: AnimatedTextureRect, robot: AnimatedTextureRect) -> void:
	# Inicia la animación para cambiar las coordenadas mostradas
	self.animation_player.animation_set_next("end_coordinate", "idle_coordinate")
	self.animation_player.play("end_coordinate")
	
	if table.compare_coordinates(robot.get_coordinates()):
		if not PlayerSession.is_practice_mode():
			self.set_score()
			# Se imprime el puntaje:
			self.print_score()
		else:
			# Se imprime el mensaje aleatorio:
			self.print_message()


# Imprime un mensaje aleatorio:
func print_message():
	var label_text: int = RandomNumberGenerator.new().randi_range(0, 100)
	if label_text >= 90:
		self.score_flash_label.text = "¡Excelente!"
	elif label_text >= 80:
		self.score_flash_label.text = "¡Muy bien!"
	elif label_text >= 70:
		self.score_flash_label.text = "¡Bien hecho!"
	elif label_text >= 60:
		self.score_flash_label.text = "¡Eso es!"
	elif label_text >= 50:
		self.score_flash_label.text = "¡Sigue así!"
	elif label_text >= 40:
		self.score_flash_label.text = "¡Gran trabajo!"
	elif label_text >= 30:
		self.score_flash_label.text = "¡Lo lograste!"
	elif label_text >= 20:
		self.score_flash_label.text = "¡Perfecto!"
	elif label_text >= 10:
		self.score_flash_label.text = "¡Increíble!"
	else:
		self.score_flash_label.text = "¡Buen esfuerzo!"
	self.score_flash_label.set("theme_override_colors/font_color", Color.CHARTREUSE)
	self.score_label_player.play("fade_out")


# Imprime el puntaje:
func print_score() -> void:
	self.score_flash_label.text = "+%s" % self.default_score
	self.score_label_player.play("fade_out")
	self.score_label.print_score()


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
	if not PlayerSession.is_practice_mode():
		self.clock.show()
		self.clock.reset_color()
		# Contiúa el reloj:
		self.clock.continue_clock()
	else:
		self.clock.stop()


# Configura la partida:
func set_game() -> void:
	if !PlayerSession.is_practice_mode():
		self.score_panel.show()
		
		# Se inicializa el puntaje en 0:
		PlayerSession.score = 0
		
		# Se reinicia el puntaje por predeterminado:
		self.default_score = 10000
	
		# Se imprime el puntaje:
		self.score_label.print_score()
		self.score_flash_label.set("theme_override_colors/font_color", Color.GREEN)

	# Se genera una coordenada:
	self.set_order_coordinates()
	
	# Se configuran el tiempo y los ingredientes:
	self.set_clock()


# Genera un par de coordenadas aleatorias:
func set_order_coordinates() -> void:
	%Robot.set_rand_coordinates()
	self.label.text = str(%Robot.get_coordinates())
	
	# Inicia la animación para mostrar las coordenadas asignadas
	self.animation_player.play("set_coordinate")


func _on_pause_finished() -> void:
	if !Mouse.mouse_mode_activated:
		pass
	self.clock.continue_clock()
	self.pause.hide()


func _on_pause_btn_pressed() -> void:
	if !self.pause.is_active():
		if !Mouse.mouse_mode_activated:
			self.pause.continue_btn.grab_focus()
		self.clock.stop()
		self.pause.show()


# Cuando se llegue a un pivote en cuenta atrás se aumenta la velocidad de la música:
func _on_clock_pivot_changed() -> void:
	# Se aumenta el pitch_scale de la música por cada minuto de juego:
	self.current_pitch += 0.1
	BackgroundMusic.change_pitch(self.current_pitch)
	
	# Se reduce el puntaje por defecto:
	self.reduce_default_score()
	
	# Se cambian los colores del score_flash_label de acuerdo a default_score:
	if self.default_score == 10000:
		self.score_flash_label.set("theme_override_colors/font_color", Color.GREEN)
	elif self.default_score == 8750:
		self.score_flash_label.set("theme_override_colors/font_color", Color.YELLOW)
	elif self.default_score == 7500:
		self.score_flash_label.set("theme_override_colors/font_color", Color.CORAL)
	elif self.default_score <= 6250:
		self.score_flash_label.set("theme_override_colors/font_color", Color.RED)


func _on_clock_countdown_finished() -> void:
	# Se reinicia el pitch de la canción:
	BackgroundMusic.change_pitch(1.0)
	
	# Se muestra la pantalla de puntajes:
	self.score_screen.show()
	self.score_screen.print_score()


func _on_score_screen_restart_game() -> void:
	# Se configura el juego/partida:
	self.set_game()
