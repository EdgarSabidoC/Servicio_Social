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
			self.character = self.zotz
		#"Uaychivo":
			#self.character = self.uaychivo
	
	self.character.enable_loop("default")
	
	# Se muestra al personaje seleccionado:
	self.character.show()
	
	# Se eliminan los personajes ocultos:
	for c in self.characters:
		if !c.is_visible_in_tree():
			c.queue_free()
	
	# Se conecta la señal de animation changed a la función de start_dialogue_box:
	self.character.connect("animation_changed", self.start_dialogue_box)


# Inicia la caja de diálogos:
func start_dialogue_box() -> void:
	# Se activa la caja de diálogo después de la animación de entrada:
	self.dialogue_box.start()


func _on_dialogue_box_dialogue_box_closed() -> void:
	# Se emite la señal de finalización de la escena:
	self.finished.emit()
