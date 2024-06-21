extends Control


@onready var dialogue_box: Control = $DialogueBox
@onready var alux: AnimatedTextureRect = $Alux
@onready var zotz: AnimatedTextureRect = $Zotz
@onready var keken: AnimatedTextureRect = $Keken
@onready var character: AnimatedTextureRect

@onready var characters: Array[AnimatedTextureRect] = [alux, zotz, keken]

func _ready() -> void:
	# Se inicializan los sprites:
	var c_name = "Keken"
	#match CharactersData.characters[PlayerSession.character].name:
	match c_name:
		"Alux":
			character = alux
		#"Toh":
			#character = toh
		"Keken":
			character = keken
		#"Huolpoch":
			#character = huolpoch
		"Zotz":
			print_debug("Entró aquí")
			character = zotz
		#"Uaychivo":
			#character = uaychivo

	# Se muestra al personaje seleccionado:
	character.show()

	# Se eliminan los personajes ocultos:
	for c in self.characters:
		if !c.is_visible_in_tree():
			c.queue_free()
	
	# Se conecta la señal de animation changed a la función de start_dialogue_box:
	character.connect("animation_changed", self.start_dialogue_box)


# Inicia la caja de diálogos:
func start_dialogue_box() -> void:
	# Se activa la caja de diálogo después de la animación de entrada:
	dialogue_box.start()
