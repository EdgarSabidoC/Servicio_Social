extends VBoxContainer

@onready var correctAnswer: bool = false
@onready var drinks = $Drinks
@onready var breads = $Breads

func _process(_delta) -> void:
	if str(drinks.value) == CharactersData.characters[0].correct_answer["drinks"] and \
	str(breads.value) == CharactersData.characters[0].correct_answer["breads"]:
		correctAnswer = true
