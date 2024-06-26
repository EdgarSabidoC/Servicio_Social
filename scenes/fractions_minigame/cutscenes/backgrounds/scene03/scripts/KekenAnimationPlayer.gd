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
	
	# Una vez termina la animación default, se cambia:
	if self.current_character.rejected:
		# Si el personaje fue rechazado:
		self.keken.current_animation = "sad"
	else:
		# Si no:
		self.keken.current_animation = "angry"
	self.keken.play()
