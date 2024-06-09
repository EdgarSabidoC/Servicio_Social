extends Button

@onready var menu_textbox: MarginContainer = $"../MarginContainer/MenuTextbox"
@export var hint: String = "Ideal para calentar"


func _on_pressed():
	# Consume el evento:
	get_viewport().set_input_as_handled()
	# Comienza la animación de desvanecimiento y cambia de escena al final de la animación:
	await change_scene()


func _on_visibility_changed():
	grab_focus()
	

# Función que cambia de escena
func change_scene():
	SceneLoader.load_scene("res://scenes/cutscenes/level_01/CutsceneLvl01.tscn")
	# Se cambia a la siguiente escena:
	#get_tree().change_scene_to_file("res://components/loading_screen/LoadingScreen.tscn")


# Al estar enfocado el botón:
func _on_focus_entered():
	self.add_theme_stylebox_override("focus", get_theme_stylebox("hover", "Button"))
	self.add_theme_font_size_override("font_size", 20)
	menu_textbox.print_message(self.hint)


# Al salir de foco del botón:
func _on_focus_exited():
	self.add_theme_font_size_override("font_size", 16)


# Al entrar el mouse al botón:
func _on_mouse_entered():
	self.add_theme_font_size_override("font_size", 20)
	menu_textbox.print_message(self.hint)


# Al salir el mouse del botón:
func _on_mouse_exited():
	self.add_theme_font_size_override("font_size", 16)
	menu_textbox.clear_message()
	
