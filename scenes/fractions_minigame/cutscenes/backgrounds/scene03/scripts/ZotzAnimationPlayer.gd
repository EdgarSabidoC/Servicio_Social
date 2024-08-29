extends AnimationPlayer

@onready var zotz: AnimatedTextureRect = $".."
@onready var current_character: CharacterResource
@onready var dialogue_box: Control = $"../../DialogueBox"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.zotz.connect("finished", self._on_zotz_finished)
	# Se obtiene de la lista de personajes el actual:
	self.current_character = CharactersData.characters[PlayerSession.character]
	self.dialogue_box.connect("dialogue_box_closed", self.start_exit)


func _on_zotz_finished() -> void:
	self.zotz.changed = true
	# Una vez termina la animación default, se cambia:
	if self.current_character.defeated:
		self.zotz.enable_loop()
	elif self.current_character.rejected:
		# Si el personaje fue rechazado:
		self.zotz.current_animation = "sad"
		# Se desactiva el loop de la animación:
		self.zotz.disable_loop()
	else:
		# Si no:
		self.zotz.current_animation = "angry"
		# Se desactiva el loop de la animación:
		self.zotz.disable_loop()
	# Se desconecta la señal:
	self.zotz.disconnect("finished", self._on_zotz_finished)
	# Se reproduce la animación:
	self.zotz.playing = true


func start_exit() -> void:
	self.play("exit")
	self.dialogue_box.disconnect("dialogue_box_closed", self.start_exit)
