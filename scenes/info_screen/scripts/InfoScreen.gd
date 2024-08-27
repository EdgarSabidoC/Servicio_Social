extends Control

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var texture_rect: TextureRect = $TextureRect
@onready var dialogue_box: Control = $DialogueBox
@export_multiline var fractions_text: String = "[StartParagraph]El juego consiste en encontrar la fracción correcta de pizza correspondiente al problema.\n\nEn dificultad media y difícil también es necesario hallar la proporción correcta de bebidas y órdenes de pan.
[StartParagraph]Completa las órdenes en el menor tiempo para conseguir más puntos."
@export_multiline var additions_text: String = "[StartParagraph]El juego consiste en realizar la suma correcta presentada en la nota de venta."
@export_multiline var coordinates_text: String = "[StartParagraph]El juego consiste en repartir las pizzas en la mesa con la coordenada correspondiente."
@export_multiline var symmetry_text: String = "[StartParagraph]El juego consiste en colocar los ingredientes correspondientes en el lado derecho y rotarlos para hacer que la pizza quede simétrica con respecto al eje Y."


## Finished signal is emitted when the info screen finishes.
signal finished


func start() -> void:
	Sfx.play_sound(Sfx.Sounds.INFO_SCREEN, 20)
	self.show()
	self.animated_sprite_2d.play()
	
	# Se carga el texto correspondiente al minijuego:
	match PlayerSession.current_minigame:
		PlayerSession.Minigames.FRACCTIONS:
			PlayerSession.fractions_info_screen = true
			self.dialogue_box.load_message(self.fractions_text)
		PlayerSession.Minigames.ADDITIONS:
			if PlayerSession.is_practice_mode():
				self.additions_text += "[StartParagraph]En el modo práctica no se adquieren puntos.\n\n[b]Modo contrareloj desactivado.[/b]"
			else: 
				self.additions_text += "[StartParagraph][b]Contrareloj activado:[/b] Mientras más tiempo pase, menos puntos obtendrás, así que sé lo más rápido que puedas."
			PlayerSession.additions_info_screen = true
			self.dialogue_box.load_message(self.additions_text)
		PlayerSession.Minigames.COORDINATES:
			if PlayerSession.is_practice_mode():
				self.coordinates_text += "[StartParagraph]En el modo práctica no se adquieren puntos.\n\n[b]Modo contrareloj desactivado.[/b]"
			else: 
				self.coordinates_text += "[StartParagraph][b]Contrareloj activado:[/b] Mientras más tiempo pase, menos puntos obtendrás, así que sé lo más rápido que puedas."
			PlayerSession.coordinates_info_screen = true
			self.dialogue_box.load_message(self.coordinates_text)
		PlayerSession.Minigames.SYMMETRY:
			if PlayerSession.is_practice_mode():
				self.symmetry_text += "[StartParagraph]En el modo práctica no se adquieren puntos.\n\n[b]Modo contrareloj desactivado.[/b]"
			else: 
				self.symmetry_text += "[StartParagraph][b]Contrareloj activado:[/b] Mientras más tiempo pase, menos puntos obtendrás, así que sé lo más rápido que puedas."
			PlayerSession.symmetry_info_screen = true
			self.dialogue_box.load_message(self.symmetry_text)
	self.dialogue_box.start()


func _on_dialogue_box_dialogue_box_closed() -> void:
	self.finished.emit()
	if !PlayerSession.destroy_info_screen():
		self.hide()
	else:
		self.queue_free()
