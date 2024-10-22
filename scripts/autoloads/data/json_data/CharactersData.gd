extends Node
class_name LoadCharacters 

const LOWER_LIMIT: int = 0
const PROBLEMS_DATA_UPPER_LIMIT: int = 9
const DIALOGUES_UPPER_LIMIT: int = 4
const NUMBER_OF_CHARACTERS: int = 5

# Rutas de los archivos .json con los datos:
@onready var characters_data_path: String = "res://assets/graphical_assets/texts/problems/fractions_minigame/characters_data.json"
@onready var easy_data_loaded: bool = false
@onready var hard_data_loaded: bool = false
@onready var medium_data_loaded: bool = false

# Se accede a la global como: CharactersData.characters
@onready var characters: Array[CharacterResource] = []

func _ready() -> void:
	# Se cargan los datos al iniciar:
	self.loadCharacters()


# Función que lee un archivo JSON y lo retorna:
func readJSON(json_file_path: String) -> Variant:
	var file: FileAccess = FileAccess.open(json_file_path, FileAccess.READ)
	var content: String = file.get_as_text()
	return JSON.parse_string(content)


# Función que carga los personajes con name, about, defeated, bonus y assets:
func loadCharacters() -> void:
	var json: Variant = readJSON(characters_data_path)
	
	if not json:
		print_debug("Error: El archivo JSON no pudo ser cargado.")
		return
	
	var characters_data: Array = json.data
	
	# Se cargan los datos de los primeros 5 personajes (0 a 4).
	for n in range(NUMBER_OF_CHARACTERS):
		# Se instancia el personaje:
		var character: CharacterResource = CharacterResource.new()
		
		# Se asignan los datos al personaje:
		character.name = characters_data[n]["name"]
		character.about = characters_data[n]["about"]
		character.bonus_multiplier = characters_data[n]["bonus_multiplier"]
		character.defeated = false
		character.rejected = false
		character.correct_answer = {}
		character.wrong_answers = []
		character.intro_text = ""
		character.outro_happy_text = ""
		character.outro_angry_text = ""
		character.outro_sad_text = ""
		character.problem = ""
		character.main_asset_path = characters_data[n]["main_asset_path"]
		
		# Se añade el personaje a la lista de personajes:
		characters.append(character)


# Función que carga los datos de todos los personajes de manera pseudoaleatoria.
# Esta función debe ser utilizada después de loadCharacters()
func loadProblemsData() -> void:
	if (PlayerSession.difficulty == "easy" and easy_data_loaded) \
	or (PlayerSession.difficulty == "medium" and medium_data_loaded) \
	or (PlayerSession.difficulty == "hard" and hard_data_loaded):
		# Test debug:
		print_debug("Datos previamente cargados")
	
	var json = readJSON(characters_data_path)
	var characters_data: Array = json.data
	var n: int
	for character in characters:
		match character.name:
			"Alux":
				n = 0
			"Huolpoch":
				n = 1
			"Toh":
				n = 2
			"Keken":
				n = 3
			"Zotz":
				n = 4
		
		# Se cambia la semilla:
		randomize()
		
		# Se mezclan los arreglos de datos:
		var intro_texts: Array = characters_data[n]["intro_texts"]
		var outro_happy_texts: Array = characters_data[n]["outro_happy_texts"]
		var outro_angry_texts: Array = characters_data[n]["outro_angry_texts"]
		var outro_sad_texts: Array = characters_data[n]["outro_sad_texts"]
		intro_texts.shuffle()
		outro_happy_texts.shuffle()
		outro_angry_texts.shuffle()
		outro_sad_texts.shuffle()
		
		# Se asignan los datos al personaje:
		character.intro_text = intro_texts[randi_range(LOWER_LIMIT,DIALOGUES_UPPER_LIMIT)]
		character.outro_happy_text = outro_happy_texts[randi_range(LOWER_LIMIT,DIALOGUES_UPPER_LIMIT)]
		character.outro_angry_text = outro_angry_texts[randi_range(LOWER_LIMIT,DIALOGUES_UPPER_LIMIT)]
		character.outro_sad_text = outro_sad_texts[randi_range(LOWER_LIMIT,DIALOGUES_UPPER_LIMIT)]
		
		# Se obtienen los datos del personaje de acuerdo a la dificultad:
		match PlayerSession.difficulty:
			"medium":
				var medium_problems_data: Array = characters_data[n]["medium_problems_data"]
				medium_problems_data.shuffle()
				character.correct_answer = medium_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT))
				var wrong_answers_array: Array[Dictionary] = [
					medium_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-1)), \
					medium_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-2)), \
					medium_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-3))
				]
				character.wrong_answers = wrong_answers_array
				character.problem = generateProblem(character.correct_answer["fraction"], character.correct_answer["drinks"], character.correct_answer["breads"])
				medium_data_loaded = true
				print_debug(character.problem)
			"hard":
				var hard_problems_data: Array = characters_data[n]["hard_problems_data"]
				hard_problems_data.shuffle()
				character.correct_answer = hard_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT))
				var wrong_answers_array: Array[Dictionary] = [
					hard_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-1)), \
					hard_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-2)), \
					hard_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-3))
				]
				character.wrong_answers = wrong_answers_array
				character.problem = generateProblem(character.correct_answer["fraction"], character.correct_answer["drinks"], character.correct_answer["breads"])
				hard_data_loaded = true
				print_debug(character.problem)
			_:
				var easy_problems_data: Array = characters_data[n]["easy_problems_data"]
				easy_problems_data.shuffle()
				character.correct_answer = easy_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT))
				var wrong_answers_array: Array[Dictionary] = [
					easy_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-1)), \
					easy_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-2)), \
					easy_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-3))
				]
				character.wrong_answers = wrong_answers_array
				character.problem = generateProblem(character.correct_answer["fraction"])
				easy_data_loaded = true
				print_debug(character.problem)

	# Se mezcla la lista de personajes:
	randomize()
	characters.shuffle()


# Función que carga los datos de problema de un personaje en específico.
# Esta función debe ser utilizada después de loadCharacters().
func loadProblemCharacter(character: CharacterResource) -> void:
	if (PlayerSession.difficulty == "easy" and easy_data_loaded) \
	or (PlayerSession.difficulty == "medium" and medium_data_loaded) \
	or (PlayerSession.difficulty == "hard" and hard_data_loaded):
		print_debug("Datos previamente cargados")
		return
	
	var json = readJSON(characters_data_path)
	var characters_data: Array = json.data
	var n: int	
	match character.name:
		"Alux":
			n = 0
		"huolpoch":
			n = 1
		"Toh":
			n = 2
		"Keken":
			n = 3
		"Zotz":
			n = 4
		
	# Se cambia la semilla:
	randomize()
	
	# Se mezclan los arreglos de datos:
	var intro_texts: Array = characters_data[n]["intro_texts"]
	var outro_happy_texts: Array = characters_data[n]["outro_happy_texts"]
	var outro_angry_texts: Array = characters_data[n]["outro_angry_texts"]
	var outro_sad_texts: Array = characters_data[n]["outro_sad_texts"]
	var problems_data: Array = characters_data[n]["problems_data"]
	intro_texts.shuffle()
	outro_happy_texts.shuffle()
	outro_angry_texts.shuffle()
	outro_sad_texts.shuffle()
	problems_data.shuffle()
	
	# Se asignan los datos al personaje:
	character.intro_text = intro_texts[randi_range(LOWER_LIMIT,DIALOGUES_UPPER_LIMIT)]
	character.outro_happy_text = outro_happy_texts[randi_range(LOWER_LIMIT,DIALOGUES_UPPER_LIMIT)]
	character.outro_angry_text = outro_angry_texts[randi_range(LOWER_LIMIT,DIALOGUES_UPPER_LIMIT)]
	character.outro_sad_text = outro_sad_texts[randi_range(LOWER_LIMIT,DIALOGUES_UPPER_LIMIT)]
	
	# Se obtienen los datos del personaje de acuerdo a la dificultad:
	match PlayerSession.difficulty:
		"medium":
			var medium_problems_data: Array = characters_data[n]["medium_problems_data"]
			medium_problems_data.shuffle()
			character.correct_answer = medium_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT))
			var wrong_answers_array: Array[Dictionary] = [
				medium_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-1)), \
				medium_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-2)), \
				medium_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-3))
			]
			character.wrong_answers = wrong_answers_array
			character.problem = generateProblem(character.correct_answer["fraction"], character.correct_answer["drinks"], character.correct_answer["breads"])
			print_debug(character.problem)
		"hard":
			var hard_problems_data: Array = characters_data[n]["hard_problems_data"]
			hard_problems_data.shuffle()
			character.correct_answer = hard_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT))
			var wrong_answers_array: Array[Dictionary] = [
				hard_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-1)), \
				hard_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-2)), \
				hard_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-3))
			]
			character.wrong_answers = wrong_answers_array
			character.problem = generateProblem(character.correct_answer["fraction"], character.correct_answer["drinks"], character.correct_answer["breads"])
			print_debug(character.problem)
		_:
			var easy_problems_data: Array = characters_data[n]["easy_problems_data"]
			easy_problems_data.shuffle()
			character.correct_answer = easy_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT))
			var wrong_answers_array: Array[Dictionary] = [
				easy_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-1)), \
				easy_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-2)), \
				easy_problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-3))
			]
			character.wrong_answers = wrong_answers_array
			character.problem = generateProblem(character.correct_answer["fraction"])
			print_debug(character.problem)


func clear_data() -> void:
	for character in self.characters:
		character.clear()


# Retorna el asset principal del personaje:
func get_character_icon(character: CharacterResource) -> Texture2D:
	return load(character.main_asset_path)


func generateProblem(fraction: String, drinks: String = "", breads: String = "") -> String:
	var problem: String = ""
	
	# Se separa la fracción:
	var new_fraction: PackedStringArray = fraction.split("/", false, 0)
	
	if new_fraction.size() != 2:
		print_debug("ERROR: Fraction can't be splitted.")
		return ""
	
	# Se obtienen el numerador y el denominador:
	var numerator: String = new_fraction[0]
	var denominator: String = new_fraction[1]
	
	# Se genera un número aleatorio entre 0 y 1:
	var probability: float = randi() % 101 / 100.0
	
	if probability <= 0.25:
		problem = "Me gustaría ordenar "
	elif probability <= 0.5:
		problem = "Quisiera "
	elif probability <= 0.75:
		problem = "Voy a querer "
	elif probability <= 1:
		problem = "Dame "
	print_debug("FRACCIÓN: ", fraction)
	print_debug("NUMERADOR: {num} DENOMINADOR: {den}".format({"num": numerator, "den": denominator}))
	var slices: String = "rebanada"
	var size: String = ""
	match denominator:
		"12":
			size = "grande"
			if probability <= 0.54:
				if numerator > "1":
					slices = "rebanadas"
					size = "grandes"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
		"8":
			size = "grande"
			if probability <= 0.65:
				if numerator > "1":
					slices = "rebanadas"
					size = "grandes"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
		"7":
			size = "mediana"
			if probability <= 0.62:
				if numerator > "1":
					slices = "rebanadas"
					size = "medianas"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
		"6":
			size = "mediana"
			if probability <= 0.55:
				if numerator > "1":
					slices = "rebanadas"
					size = "medianas"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
		"5":
			size = "chica"
			if probability <= 0.5:
				if numerator > "1":
					slices = "rebanadas"
					size = "chicas"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
		"4":
			size = "chica"
			if probability <= 0.6:
				if numerator > "1":
					slices = "rebanadas"
					size = "chicas"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
		"3":
			size = "tamaño personal"
			if probability <= 0.61:
				if numerator > "1":
					slices = "rebanadas"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
		"2":
			size = "tamaño personal"
			if probability <= 0.52:
				if numerator > "1":
					slices = "rebanadas"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
	
	if PlayerSession.difficulty != "easy":
		var _drinks: String = "refrescos"
		var _breads: String = "panes"
		if drinks == "1":
			_drinks = "refresco"
		if breads == "1":
			_breads = "pan"
		problem += ", también quiero la promoción de {drinks} {_drinks} y {breads} {_breads}, por favor.".format({"drinks": drinks, "_drinks": _drinks, "breads": breads, "_breads": _breads})
	else:
		problem += ", por favor."
	print_debug("PROBLEM: ", problem)
	return problem
