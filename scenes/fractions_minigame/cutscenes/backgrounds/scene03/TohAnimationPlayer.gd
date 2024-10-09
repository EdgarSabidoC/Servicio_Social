extends AnimationPlayer

@onready var toh: AnimatedTextureRect = $".."
@onready var current_character: CharacterResource
@onready var dialogue_box: Control = $"../../DialogueBox"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.toh.connect("finished", self._on_toh_finished)
	# Se obtiene de la lista de personajes el actual:
	self.current_character = CharactersData.characters[PlayerSession.character]
	self.dialogue_box.connect("dialogue_box_closed", self.start_exit)


func _on_toh_finished() -> void:
	self.toh.changed = true
	# Una vez termina la animación default, se cambia:
	if self.current_character.defeated:
		self.toh.enable_loop()
	elif self.current_character.rejected:
		# Si el personaje fue rechazado:
		self.toh.play("sad")
		# Se desactiva el loop de la animación:
		self.toh.disable_loop()
	else:
		# Si no:
		self.toh.play("anger")
		# Se desactiva el loop de la animación:
		self.toh.disable_loop()
	# Se desconecta la señal:
	self.toh.disconnect("finished", self._on_toh_finished)
	# Se reproduce la animación:
	self.toh.playing = true
	self.play("exit")


func start_exit() -> void:
	self.dialogue_box.disconnect("dialogue_box_closed", self.start_exit)
