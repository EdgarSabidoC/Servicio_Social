extends Node2D

class_name LevelFractionsMinigame

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


func _ready() -> void:
	# Se enfoca el botón 1 si está en modo teclado:
	if !Mouse.mouse_mode_activated:
		answer_button_1.grab_focus()
	
	# Se activan los controles de pausa:
	if !pause.is_pausable_scene:
		pause.is_pausable_scene = true
	
	character = PlayerSession.character
	
	# Se imprime el puntaje:
	score_label.print_score()
	
	# Se cargan las respuestas:
	var correct_answer: Dictionary = CharactersData.characters[self.character].correct_answer
	answers.append(correct_answer)
	var wrong_answer_1: Dictionary = CharactersData.characters[self.character].wrong_answers[0]
	answers.append(wrong_answer_1)
	var wrong_answer_2: Dictionary = CharactersData.characters[self.character].wrong_answers[1]
	answers.append(wrong_answer_2)
	var wrong_answer_3: Dictionary = CharactersData.characters[self.character].wrong_answers[2]
	answers.append(wrong_answer_3)

	# Se cambia la semilla:
	randomize()
	
	# Se mezcla el arreglo:
	answers.shuffle()
	
	# A cada botón se le asigna una respuesta:
	var count: int = 0
	for answer in answers:
		var button = buttons[count]
		if answer != correct_answer:
			button.construct(answer)
		else:
			button.construct(answer)
			button.defeated = true
		count += 1


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if !pause.is_active():
			clock.stop()
			pause.show()


# Obtiene el puntaje del nivel:
func _get_score() -> void:
	# Test debug:
	#print_debug("El personaje es %s y es %s" % [CharactersData.characters[character].name, CharactersData.characters[character].defeated])
	# Se valida si se obtuvieron los puntos correctos:
	if self.defeated and PlayerSession.difficulty != "easy" \
	and extras_container.correctAnswer:
		if clock.minutes >= 1:
			PlayerSession.score += 10000/clock.minutes
		else:
			PlayerSession.score += 10000
	elif self.defeated and PlayerSession.difficulty == "easy":
		if clock.minutes >= 1:
			PlayerSession.score += 10000/clock.minutes
		else:
			PlayerSession.score += 10000


# Función que obtiene el score al haber presionado AcceptButton:
func _on_accept_button_pressed():
	# Se obtiene el puntaje:
	_get_score()
	# Se imprime el nuevo puntaje:
	score_label.print_score()
	# Se mueve al siguiente personaje:
	if PlayerSession.next_character() == 5 and PlayerSession.difficulty != "easy":
		PlayerSession.secret_level = true
	# Se va hacia la cinemática de salida:
	SceneTransition.change_scene(outro_cutscene)


func _on_answer_button_1_pressed() -> void:
	self.defeated = answer_button_1.defeated
	# Test debug:
	print_debug(self.defeated)
	CharactersData.characters[character].defeated = self.defeated


func _on_answer_button_2_pressed() -> void:
	self.defeated = answer_button_2.defeated
	# Test debug:
	print_debug(self.defeated)
	CharactersData.characters[character].defeated = self.defeated


func _on_answer_button_3_pressed() -> void:
	self.defeated = answer_button_3.defeated
	# Test debug:
	print_debug(self.defeated)
	CharactersData.characters[character].defeated = self.defeated


func _on_answer_button_4_pressed() -> void:
	self.defeated = answer_button_4.defeated
	# Test debug:
	print_debug(self.defeated)
	CharactersData.characters[character].defeated = self.defeated


# Si se desactiva el menú de pausa:
func _on_pause_finished() -> void:
	clock.continue_clock()
	pause.hide()
