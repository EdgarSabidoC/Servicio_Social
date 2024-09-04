extends AnimationPlayer

@onready var keken: AnimatedTextureRect = $".."
@onready var current_character: CharacterResource
@onready var dialogue_box: Control = $"../../DialogueBox"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.keken.connect("finished", self._on_keken_finished)
	# Se obtiene de la lista de personajes el actual:
	self.current_character = CharactersData.characters[PlayerSession.character]
	self.dialogue_box.connect("dialogue_box_closed", self.start_exit)


func _on_keken_finished() -> void:
	self.keken.changed = true
	# Una vez termina la animación default, se cambia:
	if self.current_character.defeated:
		self.keken.enable_loop()
	elif self.current_character.rejected:
		# Si el personaje fue rechazado:
		self.keken.current_animation = "sad"
		# Se desactiva el loop de la animación:
		self.keken.disable_loop()
	else:
		# Si no:
		self.keken.current_animation = "anger"
		# Se desactiva el loop de la animación:
		self.keken.disable_loop()
	# Se desconecta la señal:
	self.keken.disconnect("finished", self._on_keken_finished)
	# Se reproduce la animación:
	self.keken.playing = true


func start_exit() -> void:
	self.play("exit")
	self.dialogue_box.disconnect("dialogue_box_closed", self.start_exit)
