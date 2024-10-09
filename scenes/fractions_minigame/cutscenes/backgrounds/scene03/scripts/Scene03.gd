extends Control

@onready var dialogue_box: Control = $DialogueBox
@onready var dialogue_box_2: Control = $DialogueBox2
@onready var alux: AnimatedTextureRect = $Alux
@onready var zotz: AnimatedTextureRect = $Zotz
@onready var keken: AnimatedTextureRect = $Keken
@onready var toh: AnimatedTextureRect = $Toh
@onready var huolpoch: AnimatedTextureRect = $Huolpoch
@onready var character: AnimatedTextureRect
@onready var characters: Array[AnimatedTextureRect] = [alux, zotz, keken, toh, huolpoch]
@onready var rich_text_label_text_flash: RichTextLabelTextFlash = $RichTextLabelTextFlash
@onready var oppossum_message: String = ""

# Señal que se emite cuando finaliza la escena:
signal finished


func _ready() -> void:
	# Se oculta el mensaje para continuar:
	self.rich_text_label_text_flash.visible = false
	# Se ocultan las cajas de diálogos:
	self.dialogue_box.hide()
	self.dialogue_box_2.hide()

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
	# Se cargan los textos:
	if CharactersData.characters[PlayerSession.character].is_rejected():
		get_rand_dialogue("rejected")
		self.dialogue_box.load_message(CharactersData.characters[PlayerSession.character].outro_sad_text)
	elif CharactersData.characters[PlayerSession.character].defeated:
		get_rand_dialogue("correct")
		self.dialogue_box.load_message(CharactersData.characters[PlayerSession.character].outro_happy_text)
	elif not CharactersData.characters[PlayerSession.character].defeated:
		get_rand_dialogue("wrong")
		self.dialogue_box.load_message(CharactersData.characters[PlayerSession.character].outro_angry_text)
	# Se carga el diálogo de la Zarigüeya:
	self.dialogue_box_2.load_message(self.oppossum_message)
	# Se activa la caja de diálogo después de la animación de entrada:
	self.dialogue_box_2.start()


func get_rand_dialogue(type: String) -> void:
	# Diálogos de introducción genéricos
	var intro_dialogues: Array[String] = [
		"¡Hola! ¿Cómo estás? ¿Qué vas a pedir hoy?",
		"Bienvenido/a, ¿en qué puedo ayudarte?",
		"Hola, parece que tienes hambre, ¿qué te gustaría comer?",
		"Hola, siempre es un gusto verte. ¿Qué te apetece hoy?",
		"Hola, estoy listo/a para tomar tu orden. ¿Qué será hoy?"
	]
	
	# Diálogos genéricos para cuando la orden está bien
	var correct_dialogues: Array[String] = [
		"¡Qué bien! Me alegra que te guste.",
		"¡Perfecto! Me alegra haber acertado con tu pedido.",
		"¡Genial! Parece que te encantó la pizza.",
		"¡Qué bueno que todo salió bien! ¡Disfruta!",
		"¡Excelente! Estoy feliz de que todo salió perfecto."
	]
	
	# Diálogos genéricos para cuando la orden está mal
	var wrong_dialogues: Array[String] = [
		"Oh, parece que algo salió mal. Lo siento.",
		"¡Ups! Creo que cometí un error con tu pedido.",
		"Parece que no es lo que esperabas, lo siento mucho.",
		"Vaya, parece que esta vez no acerté con tu pedido.",
		"Lo lamento, parece que no es lo que querías."
	]
	
	# Diálogos genéricos para cuando la orden es rechazada
	var rejected_dialogues: Array[String] = [
		"Me temo que por el momento no puedo atenderle ¡Lo siento mucho!.",
		"¡Vaya! Parece que en este momento no podemos antenderle ¡Lo sentimos mucho!",
		"Lo sentimos, pero me temo que aún no está listo el horno, vuelva más tarde, por favor.",
		"Lo sentimos, me temo que no podemos tomarle la orden en este momento.",
		"Una disculpa, pero aún no abrimos, vuelva más tarde."
	]
	
	match type:
		"intro":
			self.oppossum_message = intro_dialogues[randi_range(0, intro_dialogues.size()-1)]
		"correct":
			self.oppossum_message = correct_dialogues[randi_range(0, correct_dialogues.size()-1)]
		"wrong":
			self.oppossum_message = wrong_dialogues[randi_range(0, wrong_dialogues.size()-1)]
		"rejected":
			self.oppossum_message = rejected_dialogues[randi_range(0, rejected_dialogues.size()-1)]


func _on_dialogue_box_dialogue_box_closed() -> void:
	# Se emite la señal de finalización de la escena:
	self.finished.emit()


func _on_dialogue_box_2_dialogue_box_closed() -> void:
	# Se hace visible el mensaje para continuar:
	self.rich_text_label_text_flash.visible = true
	# Se activa el otro cuadro de diálogo:
	self.dialogue_box.start()
	
	
