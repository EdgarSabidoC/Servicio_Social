extends Node2D

# Variables:
@onready var score_panel: Panel = $CanvasLayer/ScorePanel
@onready var pause: Control = $CanvasLayer/Pause
@onready var character: int
@onready var answer_button_1: AnswerButton = $CanvasLayer/Control/GridContainer/AnswerButton1
@onready var answer_button_2: AnswerButton = $CanvasLayer/Control/GridContainer/AnswerButton2
@onready var answer_button_3: AnswerButton = $CanvasLayer/Control/GridContainer/AnswerButton3
@onready var answer_button_4: AnswerButton = $CanvasLayer/Control/GridContainer/AnswerButton4
@onready var clock: Clock = $CanvasLayer/Clock
@onready var defeated: bool = false
@onready var extras_container = $CanvasLayer/Control/ExtrasContainer
@onready var score_label = $CanvasLayer/ScorePanel/ScoreLabel
@onready var buttons: Array[AnswerButton] = [answer_button_1, answer_button_2, answer_button_3, answer_button_4]
@onready var answers: Array[Dictionary]
@onready var current_pitch = 1.0
@onready var outro_cutscene: PackedScene = load("res://scenes/fractions_minigame/cutscenes/outro_cutscene/OutroCutscene.tscn")
@onready var score_flash_label: Label = $CanvasLayer/ScoreFlashLabel
@onready var score_label_player: AnimationPlayer = $CanvasLayer/ScoreFlashLabel/AnimationPlayer

## Default score.
@onready var default_score: int = 10000

func _enter_tree() -> void:
	self.set_music()


func _ready() -> void:	
	# Se enfoca el botón 1 si está en modo teclado:
	if !Mouse.mouse_mode_activated:
		self.answer_button_1.grab_focus()
	
	# Se configura el juego/partida:
	self.set_game()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if !self.pause.is_active():
			self.clock.stop()
			self.pause.show()


func set_game() -> void:
	self.character = PlayerSession.character
	
	# Se imprime el puntaje:
	self.score_label.print_score()
	self.score_flash_label.set("theme_override_colors/font_color", Color.DARK_GREEN)
	
	# Se cargan las respuestas:
	self.load_answers()


# Carga las respuestas en los botones:
func load_answers() -> void:
	# Se cargan las respuestas:
	var correct_answer: Dictionary = CharactersData.characters[self.character].correct_answer
	self.answers.append(correct_answer)
	var wrong_answer_1: Dictionary = CharactersData.characters[self.character].wrong_answers[0]
	self.answers.append(wrong_answer_1)
	var wrong_answer_2: Dictionary = CharactersData.characters[self.character].wrong_answers[1]
	self.answers.append(wrong_answer_2)
	var wrong_answer_3: Dictionary = CharactersData.characters[self.character].wrong_answers[2]
	self.answers.append(wrong_answer_3)

	# Se cambia la semilla:
	randomize()
	
	# Se mezcla el arreglo:
	self.answers.shuffle()
	
	# A cada botón se le asigna una respuesta:
	var count: int = 0
	for answer in self.answers:
		var button = self.buttons[count]
		if answer != correct_answer:
			button.construct(answer)
		else:
			button.construct(answer)
			button.defeated = true
		count += 1


func set_music():
	# Se cambia la música:
	var current_position: float = 0
	var pitch: float = 1.0
	var volume: float = 0
	BackgroundMusic.change_song(BackgroundMusic.FUNICULI_FUNICULA, current_position, pitch, volume)


# Otorga un puntaje basándose en el tiempo:
func reduce_default_score() -> void:
	@warning_ignore("integer_division")
	PlayerSession.score += self.default_score/self.clock.minutes


# Imprime el puntaje:
func print_score() -> void:
	# Se cambian los colores del score_flash_label de acuerdo a default_score:
	if self.default_score >= 10000:
		self.score_flash_label.set("theme_override_colors/font_color", Color.DARK_GREEN)
	elif self.default_score >= 8750:
		self.score_flash_label.set("theme_override_colors/font_color", Color.BLUE)
	elif self.default_score >= 7500:
		self.score_flash_label.set("theme_override_colors/font_color", Color.BLUE_VIOLET)
	elif self.default_score >= 6250:
		self.score_flash_label.set("theme_override_colors/font_color", Color.CORAL)
	else:
		self.score_flash_label.set("theme_override_colors/font_color", Color.RED)
	
	# Se imprime el puntaje nuevo:
	self.score_flash_label.text = "+%s" % self.default_score
	self.score_label_player.play("fade_out")
	self.score_label.print_score()


# Obtiene el puntaje del nivel:
func set_score() -> void:
	# Test debug:
	print_debug("El personaje es %s y es %s" % [CharactersData.characters[character].name, CharactersData.characters[character].defeated])
	# Se valida si se obtuvieron los puntos correctos:
	if self.defeated and PlayerSession.difficulty != "easy" \
	and self.extras_container.correctAnswer:
		if self.clock.minutes < 1:
			PlayerSession.score += self.default_score
		else:
			self.reduce_default_score()
	elif self.defeated and PlayerSession.difficulty == "easy":
		if self.clock.minutes < 1:
			PlayerSession.score += self.default_score
		else:
			self.reduce_default_score()


# Función que obtiene el score al haber presionado AcceptButton:
func _on_accept_button_pressed():
	# Se obtiene el puntaje:
	self.set_score()
	if self.defeated:
		# Se muestra el puntaje obtenido en score_flash_label:
		self.print_score()
	# Se espera(n) 1 segundo(s) antes de continuar:
	await get_tree().create_timer(1).timeout
	# Se mueve al siguiente personaje:
	PlayerSession.next_character()
	# Se va hacia la cinemática de salida:
	SceneTransition.change_scene(self.outro_cutscene)


func _on_answer_button_1_pressed() -> void:
	self.defeated = self.answer_button_1.defeated
	# Test debug:
	print_debug("Defeated: %s" %self.defeated)
	CharactersData.characters[self.character].defeated = self.defeated
	print_debug("Character %s defeated: %s" %[self.character, CharactersData.characters[self.character].defeated])


func _on_answer_button_2_pressed() -> void:
	self.defeated = self.answer_button_2.defeated
	# Test debug:
	print_debug("Defeated: %s" %self.defeated)
	CharactersData.characters[self.character].defeated = self.defeated
	print_debug("Character %s defeated: %s" %[self.character, CharactersData.characters[self.character].defeated])


func _on_answer_button_3_pressed() -> void:
	self.defeated = self.answer_button_3.defeated
	# Test debug:
	print_debug("Defeated: %s" %self.defeated)
	CharactersData.characters[self.character].defeated = self.defeated
	print_debug("Character %s defeated: %s" %[self.character, CharactersData.characters[self.character].defeated])


func _on_answer_button_4_pressed() -> void:
	self.defeated = self.answer_button_4.defeated
	# Test debug:
	print_debug("Defeated: %s" %self.defeated)
	CharactersData.characters[self.character].defeated = self.defeated
	print_debug("Character %s defeated: %s" %[self.character, CharactersData.characters[self.character].defeated])


# Si se desactiva el menú de pausa:
func _on_pause_finished() -> void:
	if !Mouse.mouse_mode_activated:
		self.answer_button_1.grab_focus()
	self.clock.continue_clock()
	self.pause.hide()


func _on_pause_btn_pressed() -> void:
	if !self.pause.is_active():
			self.clock.stop()
			self.pause.show()


# Cuando se llegue a un minuto nuevo se aumenta la velocidad de la música:
func _on_clock_new_minute_reached() -> void:
	# Se aumenta el pitch_scale de la música por cada minuto de juego:
	self.current_pitch += 0.1
	BackgroundMusic.change_pitch(self.current_pitch)
