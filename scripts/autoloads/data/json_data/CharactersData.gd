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
@onready var answers_cache: Array = []
@onready var easy_fractions = [
	"1/4","2/4","3/4",
	"1/5","2/5","3/5","4/5",
	"1/7","2/7","3/7","4/7","5/7","6/7"
]

@onready var medium_fractions = [
	"1/4","2/4","3/4",
	"1/5","2/5","3/5","4/5",
	"1/7","2/7","3/7","4/7","5/7","6/7",
	"1/8","2/8","3/8","4/8","5/8","6/8","7/8",
]

@onready var hard_fractions = [
	"1/4","2/4","3/4",
	"1/5","2/5","3/5","4/5",
	"1/7","2/7","3/7","4/7","5/7","6/7",
	"1/8","2/8","3/8","4/8","5/8","6/8","7/8",
	"1/12","2/12","3/12","4/12","5/12","6/12","7/12","8/12","9/12","10/12","11/12"
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
		
		# Se genera un problema:
		var fraction: String = get_rand_fraction()
		# Respuesta correcta:
		if PlayerSession.difficulty != "easy":
			character.correct_answer = {"fraction": fraction, "imagePath": get_pizza_graph(fraction), "drinks": str(gen_rand_drinks()), "breads": str(gen_rand_breads())}
			# Se crea un problema con su respuesta correcta:
			character.problem = generateProblem(character.correct_answer["fraction"], character.correct_answer["drinks"], character.correct_answer["breads"])
		else:
			character.correct_answer = {"fraction": fraction, "imagePath": get_pizza_graph(fraction)}
			# Se crea un problema con su respuesta correcta:
			character.problem = generateProblem(character.correct_answer["fraction"])
		# Se obtienen las respuestas incorrectas:
		for i in range(0, 3):
			fraction = get_rand_fraction()
			var problem: Dictionary
			if PlayerSession.difficulty != "easy":
				problem = {"fraction": fraction, "imagePath": get_pizza_graph(fraction), "drinks": str(gen_rand_drinks()), "breads": str(gen_rand_breads())}
			else:
				problem = {"fraction": fraction, "imagePath": get_pizza_graph(fraction)}
			character.wrong_answers.append(problem)
		print_debug("\n\n")
		# Se regresan las fracciones al pool de respuestas:
		return_fractions_to_list()
	
	# Se actualizan las banderas de cargas de datos:
	if PlayerSession.difficulty == "easy":
		easy_data_loaded = true
	elif PlayerSession.difficulty == "medium":
		medium_data_loaded = true
	elif PlayerSession.difficulty == "hard":
		hard_data_loaded = true
	
	# Se mezcla la lista de personajes:
	randomize()
	characters.shuffle()


# Limpia los datos de los personajes y reinicia las banderas de las cargas de datos:
func clear_data() -> void:
	for character in self.characters:
		character.clear()
	# Se reinician las banderas de carga de datos:
	self.easy_data_loaded = false
	self.medium_data_loaded = false
	self.hard_data_loaded = false


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
			print_debug("Entró la fracción: ", fraction)
			return "res://assets/graphical_assets/environments/backgrounds/fractions_minigame/scene_02/pizzas_fractions/scene_01_pizza_1.tga"


# Obtiene una fracción aleatoria:
func get_rand_fraction() -> String:
	var fraction: String = ""
	randomize()
	match PlayerSession.difficulty:
		"hard":
			self.hard_fractions.shuffle()
			fraction = self.hard_fractions.pop_front()
			print_debug(self.hard_fractions)
		"medium":
			self.medium_fractions.shuffle()
			fraction = self.medium_fractions.pop_front()
			print_debug(self.medium_fractions)
		_:
			self.easy_fractions.shuffle()
			fraction = self.easy_fractions.pop_front()
			print_debug(self.easy_fractions)
	self.answers_cache.append(fraction)
	return fraction


# Genera un número de bebidas aleatorio:
func gen_rand_drinks() -> int:
	return randi_range(1, 5)


# Genera un número de panes aleatorio:
func gen_rand_breads() -> int:
	return randi_range(1, 10)


# Regresa las fracciones de respuestas correctas del caché a las listas originales:
func return_fractions_to_list() -> void:
	if answers_cache.is_empty():
		return
	match PlayerSession.difficulty:
		"hard":
			self.hard_fractions.append_array(answers_cache)
			self.hard_fractions.shuffle()
		"medium":
			self.medium_fractions.append_array(answers_cache)
			self.medium_fractions.shuffle()
		_:
			self.easy_fractions.append_array(answers_cache)
			self.easy_fractions.shuffle()
	self.answers_cache = []


# Retorna el asset principal del personaje:
func get_character_icon(character: CharacterResource) -> Texture2D:
	return load(character.main_asset_path)


# Verifica si dos fracciones son equivalentes:
func are_equal(fraction1: String, fraction2: String) -> bool:
	if fraction1 == fraction2:
		return true
	elif fraction1 == "2/4" or fraction1 == "4/8" or fraction1 == "6/12" or fraction1 == "1/2":
		if fraction2 == "2/4" or fraction2 == "4/8" or fraction2 == "6/12" or fraction2 == "1/2":
			return true
	elif fraction1 == "3/4" or fraction1 == "6/8" or fraction1 == "9/12":
		if fraction2 == "3/4" or fraction2 == "6/8" or fraction2 == "9/12":
			return true
	elif fraction1 == "4/4" or fraction1 == "5/5" or fraction1 == "7/7" or \
		 fraction1 == "8/8" or fraction1 == "12/12" or fraction1 == "1/1" or fraction1 == "1":
		if fraction2 == "4/4" or fraction2 == "5/5" or fraction2 == "7/7" or \
		   fraction2 == "8/8" or fraction2 == "12/12" or fraction2 == "1/1" or fraction2 == "1":
			return true
	return false


# Dados un numerador y denominador retorna el nombre de la fracción:
func fraction_name(num: String, den: String) -> String:
	var fraction: String = "{num}/{den}".format({"num": num, "den": den})
	var new_expression: String = ""
	
	if PlayerSession.difficulty == "hard":
		if (num == "2" and den == "4") or \
			(num == "6" and den == "12") or \
			(num == "4" and den == "8"):
			num = "1"
			den = "2"
		elif (num == "6" and den == "8") or (num == "9" and den == "12") :
			num = "3"
			den = "4"
	
	match fraction:
		"1":
			new_expression = "una"
		"1/1":
			new_expression = "una"
		"1/2":
			new_expression = "media"
		"1/4":
			new_expression = "un cuarto"
		"2/4":
			new_expression = "dos cuartos"
		"3/4":
			new_expression = "tres cuartos"
		"4/4":
			new_expression = "cuatro cuartos"
		"1/5":
			new_expression = "un quinto"
		"2/5":
			new_expression = "dos quintos"
		"3/5":
			new_expression = "tres quintos"
		"4/5":
			new_expression = "cuatro quintos"
		"5/5":
			new_expression = "cinco quintos"
		"1/7":
			new_expression = "un séptimo"
		"2/7":
			new_expression = "dos séptimos"
		"3/7":
			new_expression = "tres séptimos"
		"4/7":
			new_expression = "cuatro séptimos"
		"5/7":
			new_expression = "cinco séptimos"
		"6/7":
			new_expression = "seis séptimos"
		"7/7":
			new_expression = "siete séptimos"
		"1/8":
			new_expression = "un octavo"
		"2/8":
			new_expression = "dos octavos"
		"3/8":
			new_expression = "tres octavos"
		"4/8":
			new_expression = "cuatro octavos"
		"5/8":
			new_expression = "cinco octavos"
		"6/8":
			new_expression = "seis octavos"
		"7/8":
			new_expression = "siete octavos"
		"8/8":
			new_expression = "ocho octavos"
		"1/12":
			new_expression = "un doceavo"
		"2/12":
			new_expression = "dos doceavos"
		"3/12":
			new_expression = "tres doceavos"
		"4/12":
			new_expression = "cuatro doceavos"
		"5/12":
			new_expression = "cinco doceavos"
		"6/12":
			new_expression = "seis doceavos"
		"7/12":
			new_expression = "siete doceavos"
		"8/12":
			new_expression = "ocho doceavos"
		"9/12":
			new_expression = "nueve doceavos"
		"10/12":
			new_expression = "diez doceavos"
		"11/12":
			new_expression = "once doceavos"
		"12/12":
			new_expression = "doce doceavos"

	return new_expression


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
	var slices: String = "rebanada"
	var size: String = ""
	
	# Si la dificultad es diferente de fácil, se utilizan los nombres de las fracciones:
	if PlayerSession.difficulty == "hard" or (PlayerSession.difficulty == "medium" and probability <= 0.5):
		fraction = fraction_name(numerator, denominator)

	match denominator:
		"12":
			size = "extra grande"
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
			size = "tamaño personal"
			if probability <= 0.6 and PlayerSession.difficulty != "hard":
				if numerator > "1":
					slices = "rebanadas"
					size = "tamaño personal"
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
