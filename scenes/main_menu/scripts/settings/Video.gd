extends TabBar

@onready var fullscreen: CheckButton = %Fullscreen


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
		%Borderless.button_pressed = true
	
	# Se obtiene el valor de Vsync y se configura el botón
	# de acuerdo con ello.
	var vsync_index = Persistence.config.get_value("Video", "vsync")
	%Vsync.selected = vsync_index


func _on_fullscreen_toggled(toggled_on):
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS)
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Persistence.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Persistence.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
	Persistence.save_data()


func _on_borderless_toggled(toggled_on: bool) -> void:
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)
	Persistence.config.set_value("Video", "borderless", toggled_on)
	Persistence.save_data()


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
