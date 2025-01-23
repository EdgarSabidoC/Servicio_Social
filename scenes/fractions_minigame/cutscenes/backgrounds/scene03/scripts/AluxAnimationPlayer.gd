extends AnimationPlayer

@onready var alux: AnimatedTextureRect = $".."
@onready var current_character: CharacterResource
@onready var dialogue_box: Control = $"../../DialogueBox"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.alux.connect("finished", self._on_alux_finished)
	# Se obtiene de la lista de personajes el actual:
	self.current_character = CharactersData.characters[PlayerSession.character]
	self.dialogue_box.connect("dialogue_box_closed", self.start_exit)


func _on_alux_finished() -> void:
	self.alux.changed = true
	# Una vez termina la animación default, se cambia:
	if self.current_character.defeated:
		self.alux.enable_loop()
	elif self.current_character.rejected:
		# Si el personaje fue rechazado:
		self.alux.play("sad")
		# Se desactiva el loop de la animación:
		self.alux.disable_loop()
	else:
		# Si no:
		self.alux.play("anger")
		# Se desactiva el loop de la animación:
		self.alux.disable_loop()
	# Se desconecta la señal:
	self.alux.disconnect("finished", self._on_alux_finished)
	# Se reproduce la animación:
	self.alux.playing = true


func start_exit() -> void:
	self.play("exit")
	self.dialogue_box.disconnect("dialogue_box_closed", self.start_exit)
