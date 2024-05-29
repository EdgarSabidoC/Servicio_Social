extends Node

# Rutas de los archivos .json con los datos:
var pizza_data_path: String = "res://assets/graphical_assets/texts/problems/pizzas/pizzas_data.json"
var pizza_text_path: String = "res://assets/graphical_assets/texts/problems/pizzas/pizzas_text.json"

# Se accede al Autoload como: PizzaProblems.data
var data: Array[PizzaProblem]

# Configura todas las acciones y eventos predeterminados en la sección
# "Controls" dentro del archivo de configuración.
func _ready() -> void:
	# Se cargan los datos:
	loadData()


# Función que lee un archivo JSON y lo retorna:
func readJSON(json_file_path):
	var file = FileAccess.open(json_file_path, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.parse_string(content)
	if json:
		return json


# Función que carga los datos.
func loadData() -> void:
	var json_pizza_data = readJSON(pizza_data_path)
	var pizza_data: Array = json_pizza_data.pizzaData
	
	var json_pizza_text = readJSON(pizza_text_path)
	var pizza_texts: Array = json_pizza_text.pizzaTexts
	
	for n in 10:
		# Se obtiene la fecha y el tiempo actual
		var date_time = Time.get_datetime_dict_from_system()
		date_time = date_time["second"] + date_time["minute"] * 60 + date_time["hour"] * 3600 + date_time["month"] * 86400 + date_time["year"] * 31536000
		
		# Se configura la semilla con el valor calculado:
		seed(date_time)
		
		# Se reordenan los datos de los problemas:
		randomize()
		pizza_data.shuffle()
		randomize()
		pizza_texts.shuffle()
		
		# Se crear el recurso para el problema de las pizzas:
		randomize()
		var problem: PizzaProblem = PizzaProblem.new()
		problem.correctAnswer = pizza_data[17]
		problem.wrongAnswers = [pizza_data[0], pizza_data[10], pizza_data[15]]
		problem.text = pizza_texts[randi_range(1,8)]["text"].format({"a": problem.correctAnswer["fraction"], \
													"b": problem.correctAnswer["beverages"], \
													"c": problem.correctAnswer["breads"]})
		
		# Se añade el recurso a la lista problemas del juego de pizzas:
		data.append(problem)
		
		# Impresión para debug:
		print_debug("Text: {a}\nCorrect answer: {b}\nWrong answers: {c}\nUrl: {d}\n".format({"a": problem.text, \
																	 "b": problem.correctAnswer, \
																	 "c": problem.wrongAnswers, \
																	 "d": problem.correctAnswer["imagePath"]}))
