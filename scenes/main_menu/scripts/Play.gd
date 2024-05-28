extends Button

@export var hint: String = "Comienza a jugar."
@export var seconds_to_wait = 3

func _ready() -> void:
	grab_focus()


func _on_pressed() -> void:
	# Pausa la música global del menú:
	MenuBackgroundMusic.stop()
	
	# Moverse a la siguiente escena:
	change_scene()


func change_scene():
	# Obtener el nodo raíz actual
	get_tree().change_scene_to_file("res://cutscenes/level_01/CutsceneLvl01.tscn");
