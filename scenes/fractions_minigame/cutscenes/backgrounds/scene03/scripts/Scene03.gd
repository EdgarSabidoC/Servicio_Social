extends Control

@onready var dialogue_box: Control = $DialogueBox
@onready var alux: AnimatedTextureRect = $Alux
@onready var zotz: AnimatedTextureRect = $Zotz
@onready var keken: AnimatedTextureRect = $Keken
@onready var toh: AnimatedTextureRect = $Toh
@onready var huolpoch: AnimatedTextureRect = $Huolpoch
@onready var character: AnimatedTextureRect
@onready var characters: Array[AnimatedTextureRect] = [alux, zotz, keken, toh, huolpoch]

# Señal que se emite cuando finaliza la escena:
signal finished


func _ready() -> void:
	# Se oculta la caja de diálogos:
	self.dialogue_box.hide()
	# Se inicializan los sprites:
	var c_name: String = CharactersData.characters[PlayerSession.character].name
	match c_name:
		"Alux":
			self.character = self.alux
		"Toh":
			self.character = self.toh
		"Keken":
			self.character = self.keken
		"Huolpoch":
			self.character = self.huolpoch
		"Zotz":
			self.character = self.zotz
	
	# Se cambia la animación a la predeterminada y se desactiva el loop de la animación:
	self.character.current_animation = "default"
	self.character.disable_loop() # Se desactiva el loop de la animación
	self.character.play()
	
	# Se muestra al personaje seleccionado:
	self.character.show()

	# Se eliminan los personajes ocultos:
	for c in self.characters:
		if !c.is_visible_in_tree():
			c.queue_free()
	
	# Se conecta la señal de animation changed a la función de start_dialogue_box:
	if character.current_animation == "default":
		self.character.connect("animation_changed", self.start_dialogue_box)


# Inicia la caja de diálogos:
func start_dialogue_box() -> void:
	# Se desconecta la señal:
	self.character.disconnect("animation_changed", self.start_dialogue_box)
	# Se carga el texto:
	if CharactersData.characters[PlayerSession.character].is_rejected():
		self.dialogue_box.load_message(CharactersData.characters[PlayerSession.character].outro_sad_text)
	elif CharactersData.characters[PlayerSession.character].defeated:
		self.dialogue_box.load_message(CharactersData.characters[PlayerSession.character].outro_happy_text)
	elif not CharactersData.characters[PlayerSession.character].defeated:
		self.dialogue_box.load_message(CharactersData.characters[PlayerSession.character].outro_angry_text)
	# Se activa la caja de diálogo después de la animación de entrada:
	self.dialogue_box.start()


func _on_dialogue_box_dialogue_box_closed() -> void:
	# Se emite la señal de finalización de la escena:
	self.finished.emit()
