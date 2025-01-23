extends Node

const PATH = "user://settings.cfg"
var config = ConfigFile.new()
var high_scores: Array

# Configura todas las acciones y eventos predeterminados en la sección
# "Controls" dentro del archivo de configuración.
func _ready() -> void:
	# Se cargan los datos:
	load_data()


# Escribe la información en el archivo ubicado en la ruta PATH.
func save_data() -> void:
	config.save(PATH)


# Carga la configuración. Si el archivo no existe, guarda los valores
# predeterminados y retorna.
func load_data() -> void:
	if config.load(PATH) != OK:
		# Si el archivo de configuración no existe se cargan datos predeterminados
		_default_data() # Datos predeterminados
		save_data()

	# Si el archivo existe, se cargan los datos:
	load_control_settings()
	load_video_settings()
	load_audio_settings()
	load_scores()


# Obtiene los datos de audio y cambia la configuración:
func load_audio_settings() -> void:
	var master: Variant = config.get_value("Audio", "0")
	AudioServer.set_bus_volume_db(0, linear_to_db(master))

	var music: Variant = config.get_value("Audio", "1")
	AudioServer.set_bus_volume_db(1, linear_to_db(music))

	var sfx: Variant = config.get_value("Audio", "2")
	AudioServer.set_bus_volume_db(2, linear_to_db(sfx))


# Carga los controles de configuración:
func load_control_settings() -> void:
	# Obtiene todas las teclas de la sección Controls, en la función
	# load_controls_setting.
	var keys: PackedStringArray = config.get_section_keys("Controls")

	for action in InputMap.get_actions():
		if keys.has(action):
			# Obtiene cada acción desde config:
			var value: Variant = config.get_value("Controls", action)

			# Borra las acciones predeterminadas y sobreescribe con nuevos
			# valores.
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, value)


# Obtiene los datos de vídeo y cambia la configuración:
func load_video_settings() -> void:
	var screen_type: Variant = config.get_value("Video", "fullscreen")
	DisplayServer.window_set_mode(screen_type)

	var borderless: Variant = config.get_value("Video", "borderless")
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, borderless)

	var vsync_index: Variant = config.get_value("Video", "vsync")
	DisplayServer.window_set_vsync_mode(vsync_index)


func load_scores() -> void:
	var best_scores: Variant = config.get_value("BestScores", "HighScores")
	self.high_scores = str_to_var(best_scores)


# Crea la información predeterminada en un archivo de configuración:
func _default_data() -> void:
	# Valores predeterminados de las acciones:
	for action in InputMap.get_actions():
		# Test debug
		#print_debug(action)
		if InputMap.action_get_events(action).size() != 0:
			config.set_value("Controls", action, InputMap.action_get_events(action)[0])

	# Valores predeterminados de la configuración de vídeo:
	config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_FULLSCREEN)
	config.set_value("Video", "borderless", true)
	config.set_value("Video", "vsync", DisplayServer.VSYNC_DISABLED)

	# Se configuran los valores predeterminados para audio:
	var master: String = "0"
	var music: String = "1"
	var sfx: String = "2"
	config.set_value("Audio", master, 0.50)
	config.set_value("Audio", music, 0.35)
	config.set_value("Audio", sfx, 0.30)

	# Se configuran los mejores puntajes:
	var best_scores: Array = [
		["EDGAR", "18000000"],
		["CARLOS", "18000000"],
		["??????","????????"],
		["??????","????????"],
		["??????","????????"],
		["??????","????????"],
		["??????","????????"],
		["??????","????????"],
		["??????","????????"],
		["??????","????????"]
		]
	self.high_scores = best_scores
	var best_scores_string: String = JSON.stringify(best_scores)
	# Test debug:
	print_debug(best_scores_string)
	config.set_value("BestScores", "HighScores", best_scores_string)


# Función que verifica si el puntaje actual es un nuevo high score:
func is_high_score() -> bool:
	var player_score: float = PlayerSession.score
	if high_scores.size() < 10:
		return true
	for score_entry in high_scores:
		var score: float = score_entry[1].to_float()
		if player_score > score:
			return true
	return false


# Función para actualizar la lista de mejores puntajes:
func update_high_scores() -> void:
	var player_score: float = PlayerSession.score
	var player_name: String = PlayerSession.name

	# Se crea una entrada para el nuevo puntaje:
	var new_score: Array = [player_name, str(player_score)]

	# Se inserta el nuevo puntaje en la posición correcta:
	var inserted: bool = false
	for i in range(self.high_scores.size()):
		var score: float = self.high_scores[i][1].to_float()
		if player_score > score:
			self.high_scores.insert(i, new_score)
			inserted = true
			break

	# Si el puntaje es menor que todos los existentes y hay menos de 10 puntajes, se agrega al final:
	if not inserted and self.high_scores.size() < 10:
		high_scores.append(new_score)

	# Si la lista tiene más de 10 elementos, se elimina el último:
	if self.high_scores.size() > 10:
		self.high_scores.pop_back()

	# Test debug:
	#print_debug("High Scores:", self.high_scores)


# Función que convierte el arreglo de high_scores a una cadena formateada con BBCode
func get_high_scores_formatted() -> String:
	var formatted_text: String = ""
	var position: int = 1

	for score_entry in high_scores:
		var player_name: String = score_entry[0]
		var score: String = score_entry[1]

		# Añadir el número de posición
		formatted_text += "[color=yellow]" + "%02d"%position + ". [/color]\t\t"
		
		# Si el nombre es inferior a 10 chars se añaden espacios vacíos suficientes:
		while (player_name.length() < 10):
			player_name = player_name + " "
		
		if player_name.length() > 10:
			player_name.left(10)
		
		# Añadir el nombre del jugador con un ancho mínimo de 10 caracteres:
		formatted_text += "[color=white]" + player_name + " [/color]\t\t"

		# Añadir el puntaje del jugador con un ancho mínimo de 10 caracteres, relleno con espacios a la izquierda
		formatted_text += "[color=green]" + "%08d" % score.to_float() + "[/color]\n"

		position += 1

	return "[center]%s[/center]" % formatted_text
