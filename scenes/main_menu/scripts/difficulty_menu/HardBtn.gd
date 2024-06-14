extends Button

@onready var menu_textbox: MarginContainer = $"../MarginContainer/MenuTextbox"
@export var hint: String = "Sólo para los más experimentados y estudiosos"
@onready var _move_to: String = "res://scenes/cutscenes/level_01/CutsceneLvl01.tscn"


func _on_pressed():
	# Consume el evento:
	get_viewport().set_input_as_handled()
	
	# Se asigna la dificultad:
	PlayerSession.difficulty = "hard"
	
	# Comienza la animación de desvanecimiento y cambia de escena al final de la animación:
	SceneLoader.load_scene(_move_to)


# Función que cambia de escena
func change_scene():
	# Se cambia a la siguiente escena:
	get_tree().change_scene_to_file("res://cutscenes/level_01/CutsceneLvl01.tscn")


# Al estar enfocado el botón:
func _on_focus_entered():
	self.add_theme_stylebox_override("focus", get_theme_stylebox("hover", "Button"))
	self.add_theme_font_size_override("font_size", 24)
	menu_textbox.print_message(self.hint, "c")


# Al salir de foco del botón:
func _on_focus_exited():
	self.add_theme_font_size_override("font_size", 16)


# Al entrar el mouse al botón:
func _on_mouse_entered():
	self.add_theme_font_size_override("font_size", 24)
	menu_textbox.print_message(self.hint, "c")


# Al salir el mouse del botón:
func _on_mouse_exited():
	self.add_theme_font_size_override("font_size", 16)
	menu_textbox.clear_message("c")
