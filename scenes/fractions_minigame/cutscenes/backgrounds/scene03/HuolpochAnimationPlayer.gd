extends AnimationPlayer

@onready var huolpoch: AnimatedTextureRect = $".."
@onready var current_character: CharacterResource
@onready var dialogue_box: Control = $"../../DialogueBox"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.huolpoch.connect("finished", self._on_huolpoch_finished)
	# Se obtiene de la lista de personajes el actual:
	self.current_character = CharactersData.characters[PlayerSession.character]
	self.dialogue_box.connect("dialogue_box_closed", self.start_exit)


func _on_huolpoch_finished() -> void:
	self.huolpoch.changed = true
	# Una vez termina la animación default, se cambia:
	if self.current_character.defeated:
		self.huolpoch.enable_loop()
	elif self.current_character.rejected:
		# Si el personaje fue rechazado:
		self.huolpoch.play("sad")
		# Se desactiva el loop de la animación:
		self.huolpoch.disable_loop()
	else:
		# Si no:
		self.huolpoch.play("anger")
		# Se desactiva el loop de la animación:
		self.huolpoch.disable_loop()
	# Se desconecta la señal:
	self.huolpoch.disconnect("finished", self._on_huolpoch_finished)
	# Se reproduce la animación:
	self.huolpoch.playing = true
	self.play("exit")


func start_exit() -> void:
	self.dialogue_box.disconnect("dialogue_box_closed", self.start_exit)
