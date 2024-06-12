extends Control

var level_fractions_minigame = load("res://scenes/fractions_minigame/level_fractions_minigame/LevelFractionsMinigame.tscn")
const O_SOLE_MIO_SOFT_PIANO = preload("res://assets/sounds/music/o_sole_mio_soft_piano.ogg")

func _ready() -> void:
	BackgroundMusic.change_song(O_SOLE_MIO_SOFT_PIANO)


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ENTER):
		# Moverse a la siguiente escena:
		SceneTransition.change_scene(level_fractions_minigame)
		set_process(false)
