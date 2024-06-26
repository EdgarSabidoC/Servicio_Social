extends Node2D

# Canciones:
const FUNICULI_FUNICULA = preload("res://assets/sounds/music/funiculi_funicula.ogg")
const FUNICULI_FUNICULA_FASTER = preload("res://assets/sounds/music/funiculi_funicula_faster.ogg")

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
var outro_cutscene = load("res://scenes/fractions_minigame/cutscenes/outro_cutscene/OutroCutscene.tscn")
@onready var current_pitch = 1.0

func _ready() -> void:
	
	# Se cambia la música:
	var current_position: float = 0
	var pitch: float = 1.0
	var volume: float = 0
	BackgroundMusic.change_song(FUNICULI_FUNICULA, current_position, pitch, volume)
	
	# Se enfoca el botón 1 si está en modo teclado:
	if !Mouse.mouse_mode_activated:
		self.answer_button_1.grab_focus()
	
	self.character = PlayerSession.character
	
	# Se imprime el puntaje:
	self.score_label.print_score()
	
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


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if !self.pause.is_active():
			self.clock.stop()
			self.pause.show()


# Obtiene el puntaje del nivel:
func _get_score() -> void:
	# Test debug:
	#print_debug("El personaje es %s y es %s" % [CharactersData.characters[character].name, CharactersData.characters[character].defeated])
	# Se valida si se obtuvieron los puntos correctos:
	if self.defeated and PlayerSession.difficulty != "easy" \
	and self.extras_container.correctAnswer:
		if self.clock.minutes >= 1:
			@warning_ignore("integer_division")
			PlayerSession.score += 10000/self.clock.minutes
		else:
			PlayerSession.score += 10000
	elif self.defeated and PlayerSession.difficulty == "easy":
		if self.clock.minutes >= 1:
			@warning_ignore("integer_division")
			PlayerSession.score += 10000/self.clock.minutes
		else:
			PlayerSession.score += 10000


# Función que obtiene el score al haber presionado AcceptButton:
func _on_accept_button_pressed():
	# Se obtiene el puntaje:
	self._get_score()
	# Se imprime el nuevo puntaje:
	self.score_label.print_score()
	# Se mueve al siguiente personaje:
	if PlayerSession.next_character() == 5 and \
	PlayerSession.difficulty == "hard" and \
	CharactersData.characters[self.character].name == "Alux" and \
	CharactersData.characters[self.character].is_rejected():
		PlayerSession.secret_level = true
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
