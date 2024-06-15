extends AudioStreamPlayer


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


# Función que cambia el pitch:
func change_pitch(pitch: float = 1.0) -> void:
	self.pitch_scale = pitch
