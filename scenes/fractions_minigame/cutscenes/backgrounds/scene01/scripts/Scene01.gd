extends Control


@onready var dialogue_box: Control = $DialogueBox
@onready var dialogue_box_2: Control = $DialogueBox2
@onready var alux: AnimatedTextureRect = $Alux
@onready var zotz: AnimatedTextureRect = $Zotz
@onready var keken: AnimatedTextureRect = $Keken
@onready var huolpoch: AnimatedTextureRect = $Huolpoch
@onready var toh: AnimatedTextureRect = $Toh
@onready var character: AnimatedTextureRect
@onready var oppossum_message: String = ""

@onready var characters: Array[AnimatedTextureRect] = [alux, zotz, keken, toh, huolpoch]

# Señal que se emite cuando finaliza la escena:
signal finished


func _ready() -> void:
	# Se ocultan las cajas de diálogos:
	self.dialogue_box.hide()
	self.dialogue_box_2.hide()
	# Se inicializan los sprites:
	#var c_name = "Keken"
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
	# Se carga el texto de bienvenida:
	self.get_rand_dialogue()
	# Se carga el texto de entrada:
	var character_message: String = CharactersData.characters[PlayerSession.character].intro_text
	character_message += "[StartParagraph]{data}".format({"data": CharactersData.characters[PlayerSession.character].get_problem()})
	self.dialogue_box.load_message(character_message)
	# Se activa la caja de diálogo después de la animación de entrada:
	self.dialogue_box_2.start()


func _on_dialogue_box_dialogue_box_closed() -> void:
	# Se emite la señal de finalización de la escena:
	self.finished.emit()


func _on_dialogue_box_2_dialogue_box_closed() -> void:
	# Se activa la otra caja de diálogo después de la bienvenida:
	self.dialogue_box.start()


func get_rand_dialogue() -> void:
	# Diálogos de introducción genéricos
	var intro_dialogues: Array[String] = [
		"¡Hola! ¿Cómo estás? ¿Qué vas a pedir hoy?",
		"Bienvenido/a, ¿en qué puedo ayudarte?",
		"Hola, te veo hambriento, ¿qué te gustaría ordenar?",
		"Hola, siempre es un gusto verte. ¿Qué te apetece hoy?",
		"Hola, estoy listo/a para tomar tu orden. ¿Qué será hoy?"
	]

	self.oppossum_message = intro_dialogues[randi_range(0, intro_dialogues.size()-1)]
	self.dialogue_box_2.load_message(self.oppossum_message)
