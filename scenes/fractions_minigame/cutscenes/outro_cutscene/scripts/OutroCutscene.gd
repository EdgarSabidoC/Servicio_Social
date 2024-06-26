extends Control

var intro_cutscene: PackedScene = load("res://scenes/fractions_minigame/cutscenes/intro_cutscene/IntroCutscene.tscn")
var end_cutscene: PackedScene = load("res://scenes/fractions_minigame/cutscenes/end_cutscene/EndCutscene.tscn")
const O_SOLE_MIO_SOFT_PIANO = preload("res://assets/sounds/music/o_sole_mio_soft_piano.ogg")
@onready var music_starts_at: float = 15


func _ready() -> void:
	# Se desactiva el proceso de escucha de entradas:
	self.set_process_input(false)
	BackgroundMusic.change_song(self.O_SOLE_MIO_SOFT_PIANO, self.music_starts_at)


func _process(_delta: float) -> void:
	# Si la canción llega al segundo 44.5 se repite:
	if BackgroundMusic.get_playback_position() >= 44.5:
		BackgroundMusic.seek(self.music_starts_at)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("m1"):
		# Moverse a la siguiente escena:
		if PlayerSession.character < 5:
			# Se carga un nuevo nivel:
			SceneTransition.change_scene(self.intro_cutscene)
		elif PlayerSession.secret_level:
			# Se desactiva el nivel secreto:
			PlayerSession.secret_level = false
			var secret_cutscene = load("res://scenes/fractions_minigame/cutscenes/secret_level/SecretCutscene.tscn")
			SceneTransition.change_scene(secret_cutscene) # Se cambia al nivel secreto
		else:
			# Se finaliza el juego cambiando a la escena final:
			SceneTransition.change_scene(self.end_cutscene)
		set_process(false)


func _on_scene_03_finished() -> void:
	# Se activa el proceso de escucha de entradas:
	print_debug("Finalizó Scene03")
	self.set_process_input(true)
