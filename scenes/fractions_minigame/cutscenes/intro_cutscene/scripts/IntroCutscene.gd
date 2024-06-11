extends Control

var level_fractions_minigame = load("res://scenes/fractions_minigame/level_fractions_minigame/LevelFractionsMinigame.tscn")


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ENTER):
		# Moverse a la siguiente escena:
		SceneTransition.change_scene(level_fractions_minigame)
		set_process(false)
