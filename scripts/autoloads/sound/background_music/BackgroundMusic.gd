extends AudioStreamPlayer

# Enum para las canciones
enum Songs {
	FUNICULI_FUNICULA,
	FUNICULI_FUNICULA_FASTER,
	O_SOLE_MIO_SOFT_PIANO,
	TARANTELLA_NAPOLETANA_TREMOLO
}

# Diccionario que asigna los valores del enum a los streams de audio OGG VORBIS correspondientes
const _SONG_PATHS: Dictionary = {
	Songs.FUNICULI_FUNICULA: preload("res://assets/sounds/music/funiculi_funicula.ogg"),
	Songs.FUNICULI_FUNICULA_FASTER: preload("res://assets/sounds/music/funiculi_funicula_faster.ogg"),
	Songs.O_SOLE_MIO_SOFT_PIANO: preload("res://assets/sounds/music/o_sole_mio_soft_piano.ogg"),
	Songs.TARANTELLA_NAPOLETANA_TREMOLO: preload("res://assets/sounds/music/tarantella_napoletana_tremolo.ogg")
}


# Función que cambia la canción:
func change_song(_song: Songs, _position: float = 0.0, _pitch: float = 1.0, _volume: float = -10.0) -> void:
	# Se obtiene la canción:
	var _song_stream: AudioStreamOggVorbis = _SONG_PATHS.get(_song, null)
	# Se verifica que la canción exista:
	if _song_stream != null:
		# Se detiene la canción actual
		self.stop()
		# Se cambia a la nueva canción
		self.stream = _song_stream
		# Se asigna el volumen
		self.volume_db = _volume
		# Se reproduce en la posición asignada
		self.play(_position)
		# Se asigna el pitch_scale (temp y pitch de la canción)
		self.pitch_scale = _pitch
	else:
		# Si no se encuentra la canción:
		print_debug("Song not found: ", _song)


# Inicia la canción de un minijuego:
func start_minigame_song(_volume: float = -10.0, _position: float = 0.0) -> void:
	var _pitch = 1.0
	self.change_song(Songs.FUNICULI_FUNICULA, _position, _pitch, _volume)


# Inicia la canción del menú principal:
func start_menu_song(_volume: float = -10.0, _position: float = 0.0) -> void:
	var _pitch = 1.0
	self.change_song(Songs.TARANTELLA_NAPOLETANA_TREMOLO, _position, _pitch, _volume)


# Función que cambia el pitch:
func change_pitch(pitch: float = 1.0) -> void:
	self.pitch_scale = pitch
