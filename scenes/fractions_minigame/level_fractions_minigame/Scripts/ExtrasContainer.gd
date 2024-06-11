extends VBoxContainer

@onready var correctAnswer: bool = false
@onready var drinks = $Drinks
@onready var breads = $Breads
@onready var extras_container: VBoxContainer = $"."


func _enter_tree() -> void:
	# Si la dificultad es fácil, entonces se ocultan los sliders de extras:
	if PlayerSession.difficulty == "easy":
		self.hide()


func _process(_delta) -> void:
	if str(drinks.value) == CharactersData.characters[0].correct_answer["drinks"] and \
	str(breads.value) == CharactersData.characters[0].correct_answer["breads"]:
		correctAnswer = true
