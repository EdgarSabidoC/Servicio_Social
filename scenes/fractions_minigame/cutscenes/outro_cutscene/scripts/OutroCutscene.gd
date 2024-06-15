extends Control

var intro_cutscene: PackedScene = load("res://scenes/fractions_minigame/cutscenes/intro_cutscene/IntroCutscene.tscn")
var end_cutscene: PackedScene = load("res://scenes/fractions_minigame/cutscenes/end_cutscene/EndCutscene.tscn")


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ENTER):
		# Moverse a la siguiente escena:
		if PlayerSession.character < 5:
			# Se carga un nuevo nivel:
			SceneTransition.change_scene(intro_cutscene)
		elif PlayerSession.secret_level:
			# Se desactiva el nivel secreto:
			PlayerSession.secret_level = false
			var secret_cutscene = load("res://scenes/fractions_minigame/cutscenes/secret_level/SecretCutscene.tscn")
			SceneTransition.change_scene(secret_cutscene) # Se cambia al nivel secreto
		else:
			# Se finaliza el juego cambiando a la escena final:
			SceneTransition.change_scene(end_cutscene)
		set_process(false)
