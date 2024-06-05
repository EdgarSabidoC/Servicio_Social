extends VBoxContainer

@onready var correctAnswer: bool = false
@onready var drinks = $Drinks
@onready var breads = $Breads

func _process(_delta) -> void:
	if drinks.value == float(CharactersData.characters[0].correct_answer["drinks"]) and \
	breads.value == float(CharactersData.characters[0].correct_answer["breads"]):
		correctAnswer = true
