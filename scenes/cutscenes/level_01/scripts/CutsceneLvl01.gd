extends Control

const LEVEL_FRACTIONS_MINIGAME = preload("res://components/level_fractions_minigame/LevelFractionsMinigame.tscn")

func _ready() -> void:
	CharactersData.loadProblemsData() # Se cargan los datos.


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ENTER):
		# Moverse a la siguiente escena:
		var level = LEVEL_FRACTIONS_MINIGAME.instantiate()
		get_tree().root.add_child(level)
		set_process(false)
