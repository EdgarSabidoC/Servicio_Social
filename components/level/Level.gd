extends Node2D

class_name Level

@onready var answer_button_1: AnswerButton = %AnswerButton1
@onready var answer_button_2: AnswerButton = %AnswerButton2
@onready var answer_button_3: AnswerButton = %AnswerButton3
@onready var answer_button_4: AnswerButton = %AnswerButton4

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


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
