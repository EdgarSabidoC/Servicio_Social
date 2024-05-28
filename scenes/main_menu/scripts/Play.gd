extends Button

@export var hint: String = "Comienza a jugar."


func _ready() -> void:
	grab_focus()


func _on_pressed() -> void:
	# Pausa la música global del menú:
	MenuBackgroundMusic.stop()
	
	# Moverse a la siguiente escena:
	get_tree().change_scene_to_file("res://cutscenes/level_01/CutsceneLvl01.tscn")
