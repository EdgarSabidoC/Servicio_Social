extends AnimationPlayer

@onready var keken: AnimatedTextureRect = $".."
@onready var current_character: CharacterResource


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.keken.connect("finished", _on_keken_finished)
	# Se obtiene de la lista de personajes el actual:
	self.current_character = CharactersData.characters[PlayerSession.character]


func _on_keken_finished() -> void:
	self.keken.changed = true
	
	# Inicia la animación de salida:
	if self.keken.current_animation == "angry":
		print_debug("Entró")
		#self.play("exit")
		pass
		return

	# Una vez termina la animación default, se cambia:
	if self.current_character.rejected:
		# Si el personaje fue rechazado:
		self.keken.current_animation = "sad"
	else:
		# Si no:
		self.keken.current_animation = "angry"
	# Se desactiva el loop de la animación:
	self.keken.disable_loop()
	# Se reproduce la animación:
	self.keken.playing = true
