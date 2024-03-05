extends Node

const PATH = "user://settings.cfg"
var config = ConfigFile.new()

# Configura todas las acciones y eventos predeterminados en la sección
# "Controls" dentro del archivo de configuración.
func _ready() -> void:
	for action in InputMap.get_actions():
		if InputMap.action_get_events(action).size() != 0:
			config.set_value("Controls", action, InputMap.action_get_events(action)[0])
	
	# Valores predeterminados de la configuración de vídeo:
	config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
	config.set_value("Video", "borderless", false)
	config.set_value("Video", "vsync", DisplayServer.VSYNC_ENABLED)
	
	# Se configuran los valores predeterminados para audio:
	for i in range(3):
		config.set_value("Audio", str(i), 0.0)
	
	# Se cargan los datos:
	load_data()

# Escribe la información en el archivo ubicado en la ruta PATH.
func save_data() -> void:
	config.save(PATH)


# Carga la configuración. Si el archivo no existe, guarda los valores
# redeterminados y retorna.
func load_data() -> void:
	if config.load(PATH) != OK:
		save_data()
		return
	
	# Si el archivo existe, se llaman las funciones:
	load_control_setings()
	load_video_setings()

func load_control_setings() -> void:
	# Obtiene todas las teclas de la sección Controls, en la función
	# load_controls_setting.
	var keys: PackedStringArray = config.get_section_keys("Controls")
	
	for action in InputMap.get_actions():
		if keys.has(action):
			# Obtiene cada acción desde config:
			var value = config.get_value("Controls", action)
			
			# Borra las acciones predeterminadas y sobreescribe con nuevos
			# valores.
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, value)


# Obtiene los datos de vídeo y cambia la configuración:
func load_video_setings() -> void:
	var screen_type = config.get_value("Video", "fullscreen")
	DisplayServer.window_set_mode(screen_type)
	
	var borderless = config.get_value("Video", "borderless")
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, borderless)
	
	var vsync_index = config.get_value("Video", "vsync")
	DisplayServer.window_set_vsync_mode(vsync_index)
