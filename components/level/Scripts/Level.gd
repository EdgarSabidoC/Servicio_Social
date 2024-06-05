extends Node2D

class_name Level

@onready var answer_button_1: AnswerButton = %AnswerButton1
@onready var answer_button_2: AnswerButton = %AnswerButton2
@onready var answer_button_3: AnswerButton = %AnswerButton3
@onready var answer_button_4: AnswerButton = %AnswerButton4
@onready var clock = $CanvasLayer/Clock
@onready var extras_container = $CanvasLayer/Control/ExtrasContainer

@onready var buttons: Array[AnswerButton] = [answer_button_1, answer_button_2, answer_button_3, answer_button_4]
@onready var answers: Array[Dictionary]


func _ready() -> void:
	# Se cargan las respuestas:
	var correct_answer: Dictionary = CharactersData.characters[0].correct_answer
	answers.append(correct_answer)
	var wrong_answer_1: Dictionary = CharactersData.characters[0].wrong_answers[0]
	answers.append(wrong_answer_1)
	var wrong_answer_2: Dictionary = CharactersData.characters[0].wrong_answers[1]
	answers.append(wrong_answer_2)
	var wrong_answer_3: Dictionary = CharactersData.characters[0].wrong_answers[2]
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


# Obtiene el puntaje del nivel:
func get_score() -> void:
	# Se valida si se obtuvieron los spuntos correctos:
	if CharactersData.characters[0].defeated == true and \
	PlayerSession.difficulty != "easy" and extras_container.correctAnswer:
		if clock.minutes >= 1:
			PlayerSession.score += 10000/clock.minutes
		else:
			PlayerSession.score += 10000
	elif CharactersData.characters[0].defeated == true and PlayerSession.difficulty == "easy":
		if clock.minutes >= 1:
			PlayerSession.score += 10000/clock.minutes
		else:
			PlayerSession.score += 10000


# Función que obtiene el score al haber presionado AcceptButton:
func _on_accept_button_pressed():
	get_score()
	print_debug(PlayerSession.score)
