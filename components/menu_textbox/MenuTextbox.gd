extends Control

# Add text to print:
@onready var moving_text = $MovingText
@export_multiline var default_text: String = ""


signal finished()


# Imprime una cadena que se la pase y la alineación [l: left, c: center, r: right, f: fill]:
func print_message(string: String = self.default_text, alignment: String = "l") -> void:
	match alignment:
		"l":
			self.moving_text.text = "[left]%s[/left]" %string
		"c":	
			self.moving_text.text = "[center]%s[/center]" %string
		"r":
			self.moving_text.text = "[right]%s[/right]" %string
		"f":
			self.moving_text.text = "[fill]%s[/fill]" %string
	self.moving_text.move_text()


# Limpia el mensaje (imprime una cadena predeterminada):
func clear_message(alignment: String = "l") -> void:
	if self.moving_text == null or not self.moving_text:
		return
	if !self.moving_text.text.is_empty():
		self.moving_text.text = self.default_text
		self.print_message(self.moving_text.text, alignment)


# Limpia el mensaje después de que haya pasado una cantidad de segundos especificada:
func clear_message_after_time(seconds: float, alignment: String = "l") -> void:
	await get_tree().create_timer(seconds).timeout # Espera un determinado tiempo en segundos
	self.clear_message(alignment)


# Se emite una señal cuando termina el texto:
func _on_moving_text_end_of_text() -> void:
	self.finished.emit()
