extends AudioStreamPlayer

# Canciones:
const FUNICULI_FUNICULA = preload("res://assets/sounds/music/funiculi_funicula.ogg")
const FUNICULI_FUNICULA_FASTER = preload("res://assets/sounds/music/funiculi_funicula_faster.ogg")
const O_SOLE_MIO_SOFT_PIANO = preload("res://assets/sounds/music/o_sole_mio_soft_piano.ogg")
const TARANTELLA_NAPOLETANA_TREMOLO = preload("res://assets/sounds/music/tarantella_napoletana_tremolo.ogg")


# Función que cambia la canción:
func change_song(song: AudioStream, position: float = 0.0, pitch: float = 1.0, volume: float = -10.0) -> void:
	# Se detiene la canción actual:
	self.stop()
	# Se cambia a la nueva canción:
	self.stream = song
	# Se asigna el volumen:
	self.volume_db = volume
	# Se reproduce en la posición asignada:
	self.play(position)
	# Se asgina el pitch_scale (temp y pitch de la canción):
	self.pitch_scale = pitch


# Inicia la canción de un minijuego:
func start_minigame_song(volume: float = -10.0, position: float = 0.0) -> void:
	var pitch = 1.0
	self.change_song(self.FUNICULI_FUNICULA, position, pitch, volume)


# Inicia la canción del menú principal:
func start_menu_song(volume: float = -10.0, position: float = 0.0) -> void:
	var pitch = 1.0
	self.change_song(self.TARANTELLA_NAPOLETANA_TREMOLO, position, pitch, volume)


# Función que cambia el pitch:
func change_pitch(pitch: float = 1.0) -> void:
	self.pitch_scale = pitch
