extends Control

@onready var dialogue_box: Control = $DialogueBox
@onready var alux: AnimatedTextureRect = $Alux
@onready var zotz: AnimatedTextureRect = $Zotz
@onready var keken: AnimatedTextureRect = $Keken
@onready var character: AnimatedTextureRect
@onready var characters: Array[AnimatedTextureRect] = [alux, zotz, keken]

# Señal que se emite cuando finaliza la escena:
signal finished


func _ready() -> void:
	# Se inicializan los sprites:
	var c_name = "Keken"
	#match CharactersData.characters[PlayerSession.character].name:
	match c_name:
		"Alux":
			self.character = self.alux
		#"Toh":
			#self.character = self.toh
		"Keken":
			self.character = self.keken
		#"Huolpoch":
			#self.character = self.huolpoch
		"Zotz":
			print_debug("Entró aquí")
			self.character = self.zotz
		#"Uaychivo":
			#self.character = self.uaychivo
	
	# Se cambia la animación a la predeterminada y se desactiva el loop de la animación:
	self.character.current_animation = "default"
	self.character.disable_loop() # Se desactiva el loop de la animación
	
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
	# Se activa la caja de diálogo después de la animación de entrada:
	self.dialogue_box.start()
	# Se cambia el estado del cambio de animación:
	self.character.changed = false


func _on_dialogue_box_dialogue_box_closed() -> void:
	# Se emite la señal de finalización de la escena:
	self.finished.emit()
	# Se desactiva el loop de la animación:
	if self.character.current_animation == "angry":
		self.character.disable_loop("angry")
		print_debug("Se cambió la animación por %s con %s" %[self.character.current_animation, self.character.sprites.get_animation_loop("angry")])
