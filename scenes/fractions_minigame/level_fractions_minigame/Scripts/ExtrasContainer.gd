extends VBoxContainer

@onready var correctAnswer: bool = false
@onready var drinks = $Drinks
@onready var breads = $Breads
@onready var extras_container: VBoxContainer = $"."


func _ready() -> void:
	# Si la dificultad es fácil, entonces se ocultan los sliders de extras:
	if PlayerSession.difficulty == "easy":
		print_debug("NO DEBERÍA ENTRAR A PROCESS")
		self.set_process(false)
		self.hide()


func _process(_delta) -> void:
	if str(drinks.value) == CharactersData.characters[0].correct_answer["drinks"] and \
	str(breads.value) == CharactersData.characters[0].correct_answer["breads"]:
		correctAnswer = true
