extends TabBar

@onready var borderless_label: Label = $VideoOptionsContainer/VideoLabelsContainer/ScreenTypeContainer/BorderlessLabel
@onready var fullscreen: CheckButton = %Fullscreen
@onready var fullscreen_label: Label = $VideoOptionsContainer/VideoLabelsContainer/ScreenTypeContainer/FullscreenLabel

@onready var vsync_label: Label = $VideoOptionsContainer/VideoLabelsContainer/VSyncContainer/VsyncLabel
@onready var vsync: OptionButton = %Vsync
@onready var is_fullscreen: bool = false


func _ready() -> void:
	# Se obtiene el valor de pantalla completa y se configura el botón
	# de acuerdo con ello.
	var screen_type = Persistence.config.get_value("Video", "fullscreen")

	if screen_type == DisplayServer.WINDOW_MODE_FULLSCREEN:
		self.fullscreen.button_pressed = true
	
	# Se obtiene el valor de modo sin bordes y se configura el botón
	# de acuerdo con ello.
	var borderless_type = Persistence.config.get_value("Video", "borderless")
	if borderless_type:
		%Fullscreen.button_pressed = false
	
	# Se obtiene el valor de Vsync y se configura el botón
	# de acuerdo con ello.
	var vsync_index = Persistence.config.get_value("Video", "vsync")
	%Vsync.selected = vsync_index


func _on_vsync_item_selected(index: int) -> void:
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS)
	DisplayServer.window_set_vsync_mode(index)
	Persistence.config.set_value("Video", "vsync", index)
	Persistence.save_data()


func _on_vsync_item_focused(_index: int) -> void:
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS)


func _on_fullscreen_focus_entered() -> void:
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS)


func _on_borderless_focus_entered() -> void:
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS)


func _on_vsync_focus_entered() -> void:
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS)


func _on_fullscreen_pressed() -> void:
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS)
	is_fullscreen = not is_fullscreen
	if is_fullscreen:
		print_debug("Entró a modo fullscreen: ", is_fullscreen)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Persistence.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		print_debug("Entró a modo windowed borderless: ", is_fullscreen)
		# Modo sin bordes:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, is_fullscreen)
		Persistence.config.set_value("Video", "borderless", is_fullscreen)
		# Modo ventana:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Persistence.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
	Persistence.save_data()
		
