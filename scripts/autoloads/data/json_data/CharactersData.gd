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
@onready var fractions_cache: Array = []
@onready var easy_fractions = [
	"1",
	"1/4","2/4","3/4","4/4",
	"1/5","2/5","3/5","4/5","5/5",
	"1/6","2/6","3/6","4/6","5/6","6/6",
	"1/7","2/7","3/7","4/7","5/7","6/7","7/7",
]

@onready var medium_fractions = [
	"1/1",
	"1/4","2/4","3/4","4/4",
	"1/5","2/5","3/5","4/5","5/5",
	"1/6","2/6","3/6","4/6","5/6","6/6",
	"1/7","2/7","3/7","4/7","5/7","6/7","7/7",
	"1/8","2/8","3/8","4/8","5/8","6/8","7/8","8/8"
]

@onready var hard_fractions = [
	"1",
	"1/4","2/4","3/4","4/4",
	"1/5","2/5","3/5","4/5","5/5",
	"1/6","2/6","3/6","4/6","5/6","6/6",
	"1/7","2/7","3/7","4/7","5/7","6/7","7/7",
	"1/8","2/8","3/8","4/8","5/8","6/8","7/8","8/8",
	"1/12","2/12","3/12","4/12","5/12","6/12","7/12","8/12","9/12","10/12","11/12","12/12"
]

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
		character.intro_text = intro_texts[randi_range(LOWER_LIMIT, DIALOGUES_UPPER_LIMIT)]
		character.outro_happy_text = outro_happy_texts[randi_range(LOWER_LIMIT, DIALOGUES_UPPER_LIMIT)]
		character.outro_angry_text = outro_angry_texts[randi_range(LOWER_LIMIT, DIALOGUES_UPPER_LIMIT)]
		character.outro_sad_text = outro_sad_texts[randi_range(LOWER_LIMIT, DIALOGUES_UPPER_LIMIT)]
		
		# Se obtienen los datos del personaje de acuerdo a la dificultad:
		match PlayerSession.difficulty:
			"medium":
				var medium_problems_data: Array = characters_data[n]["medium_problems_data"]
				medium_problems_data.shuffle()
				character.correct_answer = medium_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT))
				var wrong_answers_array: Array[Dictionary] = [
					medium_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 1)), \
					medium_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 2)), \
					medium_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 3))
				]
				character.wrong_answers = wrong_answers_array
				character.problem = generateProblem(character.correct_answer["fraction"], character.correct_answer["drinks"], character.correct_answer["breads"])
				medium_data_loaded = true
				print_debug(character.problem)
			"hard":
				var hard_problems_data: Array = characters_data[n]["hard_problems_data"]
				hard_problems_data.shuffle()
				character.correct_answer = hard_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT))
				var wrong_answers_array: Array[Dictionary] = [
					hard_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 1)), \
					hard_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 2)), \
					hard_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 3))
				]
				character.wrong_answers = wrong_answers_array
				character.problem = generateProblem(character.correct_answer["fraction"], character.correct_answer["drinks"], character.correct_answer["breads"])
				hard_data_loaded = true
				print_debug(character.problem)
			_:
				var easy_problems_data: Array = characters_data[n]["easy_problems_data"]
				easy_problems_data.shuffle()
				character.correct_answer = easy_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT))
				var wrong_answers_array: Array[Dictionary] = [
					easy_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 1)), \
					easy_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 2)), \
					easy_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 3))
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
	character.intro_text = intro_texts[randi_range(LOWER_LIMIT, DIALOGUES_UPPER_LIMIT)]
	character.outro_happy_text = outro_happy_texts[randi_range(LOWER_LIMIT, DIALOGUES_UPPER_LIMIT)]
	character.outro_angry_text = outro_angry_texts[randi_range(LOWER_LIMIT, DIALOGUES_UPPER_LIMIT)]
	character.outro_sad_text = outro_sad_texts[randi_range(LOWER_LIMIT, DIALOGUES_UPPER_LIMIT)]
	
	# Se obtienen los datos del personaje de acuerdo a la dificultad:
	match PlayerSession.difficulty:
		"medium":
			var medium_problems_data: Array = characters_data[n]["medium_problems_data"]
			medium_problems_data.shuffle()
			character.correct_answer = medium_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT))
			var wrong_answers_array: Array[Dictionary] = [
				medium_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 1)), \
				medium_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 2)), \
				medium_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 3))
			]
			character.wrong_answers = wrong_answers_array
			character.problem = generateProblem(character.correct_answer["fraction"], character.correct_answer["drinks"], character.correct_answer["breads"])
			print_debug(character.problem)
		"hard":
			var hard_problems_data: Array = characters_data[n]["hard_problems_data"]
			hard_problems_data.shuffle()
			character.correct_answer = hard_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT))
			var wrong_answers_array: Array[Dictionary] = [
				hard_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 1)), \
				hard_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 2)), \
				hard_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 3))
			]
			character.wrong_answers = wrong_answers_array
			character.problem = generateProblem(character.correct_answer["fraction"], character.correct_answer["drinks"], character.correct_answer["breads"])
			print_debug(character.problem)
		_:
			var easy_problems_data: Array = characters_data[n]["easy_problems_data"]
			easy_problems_data.shuffle()
			character.correct_answer = easy_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT))
			var wrong_answers_array: Array[Dictionary] = [
				easy_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 1)), \
				easy_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 2)), \
				easy_problems_data.pop_at(randi_range(LOWER_LIMIT, PROBLEMS_DATA_UPPER_LIMIT - 3))
			]
			character.wrong_answers = wrong_answers_array
			character.problem = generateProblem(character.correct_answer["fraction"])
			print_debug(character.problem)


func clear_data() -> void:
	for character in self.characters:
		character.clear()


# Obtiene la ruta del gráfica de una pizza dada una fracción:
func get_pizza_graph(fraction: String) -> String:
	match fraction:
		"1/4":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_1_4.tga"
		"2/4":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_2_4.tga"
		"3/4":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_3_4.tga"
		"1/5":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_1_5.tga"
		"2/5":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_2_5.tga"
		"3/5":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_3_5.tga"
		"4/5":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_4_5.tga"
		"1/7":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_1_7.tga"
		"2/7":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_2_7.tga"
		"3/7":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_3_7.tga"
		"4/7":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_4_7.tga"
		"5/7":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_5_7.tga"
		"6/7":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_6_7.tga"
		"1/8":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_1_8.tga"
		"2/8":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_2_8.tga"
		"3/8":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_3_8.tga"
		"4/8":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_4_8.tga"
		"5/8":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_5_8.tga"
		"6/8":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_6_8.tga"
		"7/8":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_7_8.tga"
		"1/12":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_1_12.tga"
		"2/12":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_2_12.tga"
		"3/12":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_3_12.tga"
		"4/12":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_4_12.tga"
		"5/12":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_5_12.tga"
		"6/12":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_6_12.tga"
		"7/12":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_7_12.tga"
		"8/12":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_8_12.tga"
		"9/12":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_9_12.tga"
		"10/12":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_10_12.tga"
		"11/12":
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_11_12.tga"
		_:
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_1.tga"


# Obtiene una fracción aleatoria:
func get_rand_fraction() -> String:
	var fraction: String = ""
	randomize()
	match PlayerSession.difficulty:
		"hard":
			hard_fractions.shuffle()
			fraction = hard_fractions.pop_at(randi() % hard_fractions.size())
		"medium":
			medium_fractions.shuffle()
			fraction = medium_fractions.pop_at(randi() % medium_fractions.size())
		_:
			easy_fractions.shuffle()
			fraction = easy_fractions.pop_at(randi() % easy_fractions.size())
	fractions_cache.append(fraction)
	return fraction


# Retorna el asset principal del personaje:
func get_character_icon(character: CharacterResource) -> Texture2D:
	return load(character.main_asset_path)


# Dado un numerador y un denominador de una fracción, genera una expresión aritmética.
func generateExpressionFromFraction(num: String, den: String) -> String:
	var allowed_denominators = [2, 3, 4, 5, 6, 7, 8, 12]
	var operations = ["+", "-", "*"]
	
	# Se convierten a enteros el numerador y el denominador:
	var numerator: int = int(num)
	var denominator: int = int(den)

	# Valida denominador y numerador
	if denominator not in allowed_denominators or numerator <= 0 or numerator > denominator:
		print_debug("ERROR: Denominador o numerador inválidos.")
		return ""

	# Elige una operación aleatoriamente (suma, resta, multiplicación)
	var chosen_operation: String = operations[randi() % operations.size()]
	
	# Se genera la expresión:
	var expression: String = ""
	match chosen_operation:
		"+": # Generar suma
			var frac: Array = generateFractionLessThan(numerator, denominator)
			var num2 = numerator * frac[1] - frac[0] * denominator
			var den2 = denominator * frac[1]
			expression = "{num1}/{den1} + {num2}/{den2}".format({"num1": frac[0], "den1": frac[1], "num2": num2, "den2": den2})
		
		"-": # Generar resta
			var frac: Array = generateFractionGreaterThan(numerator, denominator)
			var num2: int = frac[0] * denominator - numerator * frac[1]
			var den2: int = denominator * frac[1]
			expression = "{num1}/{den1} - {num2}/{den2}".format({"num1": frac[0], "den1": frac[1], "num2": num2, "den2": den2})
		
		"*": # Generar multiplicación
			var factor = findFactorForFraction(numerator, denominator)
			@warning_ignore("integer_division")
			var num1: int = numerator / factor
			@warning_ignore("integer_division")
			var den1: int = denominator / factor
			expression = "{num1}/{den1} * {factor}/{factor}".format({"num1": num1, "den1": den1, "factor": factor})
	
	return expression


# Genera una fracción menor que la original (para suma)
func generateFractionLessThan(numerator: int, denominator: int) -> Array:
	var num1 = randi() % numerator + 1
	var den1 = denominator
	return [num1, den1]


# Genera una fracción mayor que la original (para resta)
func generateFractionGreaterThan(numerator: int, denominator: int) -> Array:
	var num1 = randi() % (denominator - numerator) + numerator + 1
	var den1 = denominator
	return [num1, den1]


# Encuentra un factor multiplicativo para la fracción
func findFactorForFraction(numerator: int, denominator: int) -> int:
	@warning_ignore("integer_division")
	var factor = randi() % (denominator / numerator) + 1
	return factor


# Genera un problema
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
	
	# Si la dificultad es difícil se genera una expresión aritmética:
	if PlayerSession.difficulty == "hard":
		fraction = generateExpressionFromFraction(numerator, denominator)

	match denominator:
		"12":
			size = "grande"
			if probability <= 0.54 and PlayerSession.difficulty == "medium":
				if numerator > "1":
					slices = "rebanadas"
					size = "grandes"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
		"8":
			size = "grande"
			if probability <= 0.65 and PlayerSession.difficulty == "medium":
				if numerator > "1":
					slices = "rebanadas"
					size = "grandes"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
		"7":
			size = "mediana"
			if probability <= 0.62 and PlayerSession.difficulty == "medium":
				if numerator > "1":
					slices = "rebanadas"
					size = "medianas"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
		"6":
			size = "mediana"
			if probability <= 0.55 and PlayerSession.difficulty != "hard":
				if numerator > "1":
					slices = "rebanadas"
					size = "medianas"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
		"5":
			size = "chica"
			if probability <= 0.5 and PlayerSession.difficulty != "hard":
				if numerator > "1":
					slices = "rebanadas"
					size = "chicas"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
		"4":
			size = "chica"
			if probability <= 0.6 and PlayerSession.difficulty != "hard":
				if numerator > "1":
					slices = "rebanadas"
					size = "chicas"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
		"3":
			size = "tamaño personal"
			if probability <= 0.61 and PlayerSession.difficulty != "hard":
				if numerator > "1":
					slices = "rebanadas"
				problem += "{numerator} {slices} {size}".format({"numerator": numerator, "slices": slices, "size": size})
			else:
				problem += "{fraction} de pizza {size}".format({"fraction": fraction, "size": size})
		"2":
			size = "tamaño personal"
			if probability <= 0.52 and PlayerSession.difficulty != "hard":
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
