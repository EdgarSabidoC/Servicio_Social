extends Node

const PATH = "user://settings.cfg"
var config = ConfigFile.new()


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
		return
	
	# Si el archivo existe, se cargan los datos:
	load_control_settings()
	load_video_settings()


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


# Crea la información predeterminada en un archivo de configuración:
func _default_data() -> void:
	# Valores predeterminados de las acciones:
	for action in InputMap.get_actions():
		if InputMap.action_get_events(action).size() != 0:
			config.set_value("Controls", action, InputMap.action_get_events(action)[0])
	
	# Valores predeterminados de la configuración de vídeo:
	config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
	config.set_value("Video", "borderless", false)
	config.set_value("Video", "vsync", DisplayServer.VSYNC_DISABLED)
	
	# Se configuran los valores predeterminados para audio:
	var master: String = "0"
	var music: String = "1"
	var sfx: String = "2"
	config.set_value("Audio", master, 0.50)
	config.set_value("Audio", music, 0.25)
	config.set_value("Audio", sfx, 0.25)
