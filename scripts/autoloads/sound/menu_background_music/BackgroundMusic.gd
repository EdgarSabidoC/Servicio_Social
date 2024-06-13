extends AudioStreamPlayer


# Función que cambia la canción:
func change_song(song: AudioStream) -> void:
	self.stop()
	self.stream = song
	self.play()
