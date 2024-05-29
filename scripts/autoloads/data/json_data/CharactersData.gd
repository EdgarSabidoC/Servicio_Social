extends Node
class_name LoadCharacters 

# Rutas de los archivos .json con los datos:
var characters_data_path: String = "res://assets/graphical_assets/texts/problems/pizzas/characters_data.json"
const LOWER_LIMIT: int = 0
const PROBLEMS_DATA_UPPER_LIMIT: int = 9
const PROBLEMS_UPPER_LIMIT: int = 4
const NUMBER_OF_CHARACTERS: int = 5

@export var difficulty: String

# Se accede al Autoload como: CharactersData.characters
var characters: Array[CharacterResource]


func _ready() -> void:
	# Se cargan los datos al iniciar:
	loadCharacters()


# Función que lee un archivo JSON y lo retorna:
func readJSON(json_file_path):
	var file = FileAccess.open(json_file_path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.parse_string(content)
	if json:
		return json

# *NOTA: Faltan cargar sus assets.
# Función que carga los personajes con nombre, defeated, bonus y assets:
func loadCharacters() -> void:
	var json = readJSON(characters_data_path)
	var characters_data: Array = json.data
	
	for n in NUMBER_OF_CHARACTERS:
		
		# Se instancia el personaje:
		var character: CharacterResource = CharacterResource.new()
		
		# Se asignan los datos al personaje:
		character.name = characters_data[n]["name"]
		character.bonus_multiplier = characters_data[n]["bonus_multiplier"]
		character.defeated = false
		
		# Se añade el personaje a la lista de personajes:
		characters.append(character)
		
		# Impresión para debug:
		#print_debug(character.name+" "+str(character.bonus_multiplier))


# Función que carga los datos de los problemas de manera pseudoaleatoria.
func loadProblemsData() -> void:
	var json = readJSON(characters_data_path)
	var characters_data: Array = json.data
	var n: int	
	for character in characters:
		match character.name:
			"Alux":
				n = 0
			"Tolok":
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
		var outro_texts: Array = characters_data[n]["outro_texts"]
		var problems_data: Array = characters_data[n]["problems_data"]
		intro_texts.shuffle()
		outro_texts.shuffle()
		problems_data.shuffle()
		
		# Se asignan los datos al personaje:
		character.intro_text = intro_texts[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		character.outro_text = intro_texts[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		character.correct_asnwer = problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT))
		var wrong_answers_array: Array[Dictionary] = [
			problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-1)), \
			problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-2)), \
			problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-3))
		]
		character.wrong_asnwers = wrong_answers_array
		
		# Se obtienen los datos del personaje de acuerdo a la dificultad:
		match difficulty:
			"medium":
				var medium_problems: Array = characters_data[n]["medium_problems"]
				medium_problems.shuffle()
				character.problem = medium_problems[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
			"hard":
				var hard_problems: Array = characters_data[n]["hard_problems"]
				hard_problems.shuffle()
				character.problem = hard_problems[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
			_:
				var easy_problems: Array = characters_data[n]["easy_problems"]
				easy_problems.shuffle()
				character.problem = easy_problems[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		
		# Impresión para debug:
		#print_debug(character.intro_text)

	# Se mezcla la lista de personajes:
	randomize()
	characters.shuffle()
	
	if difficulty == "hard":
		# Se instancia el personaje Uaychivo:
		var uaychivo: CharacterResource = CharacterResource.new()
		# Se cambia la semilla:
		randomize()
		
		# Se mezclan los arreglos de datos:
		var hard_problems: Array = characters_data[NUMBER_OF_CHARACTERS]["hard_problems"]
		var intro_texts: Array = characters_data[NUMBER_OF_CHARACTERS]["intro_texts"]
		var outro_texts: Array = characters_data[NUMBER_OF_CHARACTERS]["outro_texts"]
		var problems_data: Array = characters_data[NUMBER_OF_CHARACTERS]["problems_data"]
		intro_texts.shuffle()
		outro_texts.shuffle()
		problems_data.shuffle()
		hard_problems.shuffle()
		
		# Se asignan los datos al personaje:
		uaychivo.name = characters_data[NUMBER_OF_CHARACTERS]["name"]
		uaychivo.bonus_multiplier = characters_data[NUMBER_OF_CHARACTERS]["bonus_multiplier"]
		uaychivo.defeated = false
		uaychivo.problem = hard_problems[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		uaychivo.intro_text = intro_texts[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		uaychivo.outro_text = intro_texts[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		uaychivo.correct_asnwer = problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT))
		var wrong_answers_array: Array[Dictionary] = [
			problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-1)), \
			problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-2)), \
			problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-3))
		]
		uaychivo.wrong_asnwers = wrong_answers_array
		# Se añade el uaychivo a la lista de personajes:
		characters.append(uaychivo)
	
	
