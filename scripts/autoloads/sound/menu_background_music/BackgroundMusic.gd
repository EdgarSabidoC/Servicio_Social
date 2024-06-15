extends AudioStreamPlayer


# Función que cambia la canción:
func change_song(song: AudioStream, position: float = 0) -> void:
	self.stop()
	self.stream = song
	self.play(position)
