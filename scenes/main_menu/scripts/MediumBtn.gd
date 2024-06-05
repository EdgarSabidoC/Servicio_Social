extends Button


func _on_pressed():
	# Prueba para imprimir datos de CharactersData:
	var cd = get_tree().root.get_node("CharactersData")
	cd.difficulty = "medium"
	cd.loadProblemsData() # Se cargan los datos.
	print(cd.characters[0]["name"]) # Ejemplo de impresión del personaje del nivel 1.
	# Consume el evento:
	get_viewport().set_input_as_handled()
	# Comienza la animación de desvanecimiento y cambia de escena al final de la animación:
	await change_scene()


# Función que cambia de escena
func change_scene():
	# Se cambia a la siguiente escena:
	get_tree().change_scene_to_file("res://cutscenes/level_01/CutsceneLvl01.tscn")
