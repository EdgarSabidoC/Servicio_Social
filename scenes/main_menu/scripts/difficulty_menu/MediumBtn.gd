extends Button

@onready var menu_textbox: MarginContainer = $"../MarginContainer/MenuTextbox"
@export_multiline var hint: String = "La manera ideal de jugar"
@onready var _move_to: String


func _on_pressed():
	# Se selecciona el minijuego:
	match PlayerSession.current_minigame:
		PlayerSession.Minigames.FRACCTIONS:
			self._move_to = "res://scenes/fractions_minigame/cutscenes/intro_cutscene/IntroCutscene.tscn"
		PlayerSession.Minigames.ADDITIONS:
			self._move_to = "res://scenes/additions_minigame/level_additions_minigame/LevelAdditionsMinigame.tscn"
		PlayerSession.Minigames.COORDINATES:
			self._move_to = "res://scenes/coordinates_minigame/level_coordinates_minigame/LevelCoordinatesMinigame.tscn"
		PlayerSession.Minigames.SYMMETRY:
			self._move_to = "res://scenes/symmetry_minigame/level_symmetry_minigame/LevelSymmetryMinigame.tscn"
	# Se para la música global del menú:
	BackgroundMusic.stop()
	
	# Se cargan los datos del personaje:
	PlayerSession.difficulty = "medium"
	
	# Se cargan los datos de los problemas de los diferentes personajes:
	CharactersData.loadProblemsData()
	
	# Consume el evento:
	get_viewport().set_input_as_handled()
	
	# Comienza la animación de desvanecimiento y cambia de escena al final de la animación:
	SceneLoader.load_scene(self._move_to)


# Al estar enfocado el botón:
func _on_focus_entered():
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS, 10)
	self.add_theme_stylebox_override("focus", get_theme_stylebox("hover", "Button"))
	self.add_theme_font_size_override("font_size", 24)
	menu_textbox.print_message(self.hint, "c")


# Al salir de foco del botón:
func _on_focus_exited():
	self.add_theme_font_size_override("font_size", 16)


# Al entrar el mouse al botón:
func _on_mouse_entered():
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS, 10)
	self.add_theme_font_size_override("font_size", 24)
	self.menu_textbox.print_message(self.hint, "c")


# Al salir el mouse del botón:
func _on_mouse_exited():
	self.add_theme_font_size_override("font_size", 16)
	self.menu_textbox.clear_message("c")
