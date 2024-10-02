extends Node
class_name LoadCharacters 

const LOWER_LIMIT: int = 0
const PROBLEMS_DATA_UPPER_LIMIT: int = 9
const PROBLEMS_UPPER_LIMIT: int = 4
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
		var problems_data: Array = characters_data[n]["problems_data"]
		intro_texts.shuffle()
		outro_happy_texts.shuffle()
		outro_angry_texts.shuffle()
		outro_sad_texts.shuffle()
		problems_data.shuffle()
		
		# Se asignan los datos al personaje:
		character.intro_text = intro_texts[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		character.outro_happy_text = outro_happy_texts[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		character.outro_angry_text = outro_angry_texts[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		character.outro_sad_text = outro_sad_texts[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		character.correct_answer = problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT))
		var wrong_answers_array: Array[Dictionary] = [
			problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-1)), \
			problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-2)), \
			problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-3))
		]
		character.wrong_answers = wrong_answers_array
		
		# Se obtienen los datos del personaje de acuerdo a la dificultad:
		match PlayerSession.difficulty:
			"medium":
				var medium_problems: Array = characters_data[n]["medium_problems"]
				medium_problems.shuffle()
				medium_data_loaded = true
				character.problem = medium_problems[randi_range(LOWER_LIMIT, PROBLEMS_UPPER_LIMIT)]
			"hard":
				var hard_problems: Array = characters_data[n]["hard_problems"]
				hard_problems.shuffle()
				hard_data_loaded = true
				character.problem = hard_problems[randi_range(LOWER_LIMIT, PROBLEMS_UPPER_LIMIT)]
			_:
				var easy_problems: Array = characters_data[n]["easy_problems"]
				easy_problems.shuffle()
				easy_data_loaded = true
				character.problem = easy_problems[randi_range(LOWER_LIMIT, PROBLEMS_UPPER_LIMIT)]

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
	character.intro_text = intro_texts[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
	character.outro_happy_text = outro_happy_texts[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
	character.outro_angry_text = outro_angry_texts[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
	character.outro_sad_text = outro_sad_texts[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
	character.correct_answer = problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT))
	var wrong_answers_array: Array[Dictionary] = [
		problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-1)), \
		problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-2)), \
		problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-3))
	]
	character.wrong_answers = wrong_answers_array
	
	# Se obtienen los datos del personaje de acuerdo a la dificultad:
	match PlayerSession.difficulty:
		"medium":
			var medium_problems: Array = characters_data[n]["medium_problems"]
			medium_problems.shuffle()
			medium_data_loaded = true
			character.problem = medium_problems[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		"hard":
			var hard_problems: Array = characters_data[n]["hard_problems"]
			hard_problems.shuffle()
			hard_data_loaded = true
			character.problem = hard_problems[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		_:
			var easy_problems: Array = characters_data[n]["easy_problems"]
			easy_problems.shuffle()
			easy_data_loaded = true
			character.problem = easy_problems[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]


func clear_data() -> void:
	for character in self.characters:
		character.clear()


# Retorna el asset principal del personaje:
func get_character_icon(character: CharacterResource) -> Texture2D:
	return load(character.main_asset_path)
