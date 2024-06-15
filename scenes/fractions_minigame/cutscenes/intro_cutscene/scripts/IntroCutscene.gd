extends Control

var level_fractions_minigame = load("res://scenes/fractions_minigame/level_fractions_minigame/LevelFractionsMinigame.tscn")
const O_SOLE_MIO_SOFT_PIANO: AudioStream = preload("res://assets/sounds/music/o_sole_mio_soft_piano.ogg")
@onready var music_starts_at: float = 0.5

func _ready() -> void:
	# Se cambia la canción:
	BackgroundMusic.change_song(O_SOLE_MIO_SOFT_PIANO, music_starts_at)


func _process(_delta: float) -> void:
	# Si la canción llega al segundo 44.5 se repite:
	if BackgroundMusic.get_playback_position() >= 45:
		BackgroundMusic.seek(music_starts_at)

	if Input.is_key_pressed(KEY_ENTER):
		# Moverse a la siguiente escena:
		SceneTransition.change_scene(level_fractions_minigame)
		set_process(false)
