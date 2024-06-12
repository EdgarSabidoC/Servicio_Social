extends AudioStreamPlayer


func change_song(song: AudioStream) -> void:
	self.stop()
	self.stream = song
	self.play()
