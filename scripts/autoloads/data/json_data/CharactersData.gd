extends Node

# Rutas de los archivos .json con los datos:
var characters_data_path: String = "res://assets/graphical_assets/texts/problems/pizzas/characters_data.json"
const LOWER_LIMIT: int = 0
const PROBLEMS_DATA_UPPER_LIMIT: int = 9
const PROBLEMS_UPPER_LIMIT: int = 4

# Se accede al Autoload como: CharactersData.characters
var characters: Array[CharacterResource]


func _ready() -> void:
	# Se cargan los datos al iniciar:
	loadData()


# Función que lee un archivo JSON y lo retorna:
func readJSON(json_file_path):
	var file = FileAccess.open(json_file_path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.parse_string(content)
	if json:
		return json


# Función que carga los datos de manera pseudoaleatoria.
func loadData() -> void:
	var json = readJSON(characters_data_path)
	var characters_data: Array = json.data
	
	for n in 6:
		# Se cambia la semilla:
		randomize()
		
		# Se instancia el personaje:
		var character: CharacterResource = CharacterResource.new()
		
		# Se obtienen los datos para inciarlizar al personaje:
		var easy_problems: Array = characters_data[n]["easy_problems"]
		var medium_problems: Array = characters_data[n]["medium_problems"]
		var hard_problems: Array = characters_data[n]["hard_problems"]
		var intro_texts: Array = characters_data[n]["intro_texts"]
		var problems_data: Array = characters_data[n]["problems_data"]
		
		# Se mezclan los arreglos de datos:
		easy_problems.shuffle()
		medium_problems.shuffle()
		hard_problems.shuffle()
		intro_texts.shuffle()
		problems_data.shuffle()
		
		# Se asignan los datos al personaje:
		character.name = characters_data[n]["name"]
		character.easy_problem = easy_problems[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		character.medium_problem = medium_problems[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		character.hard_problem = hard_problems[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		character.bonus_multiplier = characters_data[n]["bonus_multiplier"]
		character.defeated = false
		character.intro_text = intro_texts[randi_range(LOWER_LIMIT,PROBLEMS_UPPER_LIMIT)]
		character.correct_asnwer = problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT))
		var wrong_answers_array: Array[Dictionary] = [
			problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-1)), \
			problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-2)), \
			problems_data.pop_at(randi_range(LOWER_LIMIT,PROBLEMS_DATA_UPPER_LIMIT-3))
		]
		character.wrong_asnwers = wrong_answers_array
		
		# Se añade el personaje a la lista de personajes:
		characters.append(character)
		
		# Impresión para debug:
		#print_debug(character.name)
