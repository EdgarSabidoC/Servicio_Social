extends Control

const ALUX = preload("res://components/characters/alux/Alux.tscn")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	var character: AnimatedSprite2D
	#character = ALUX.instantiate()
	# Se inicializan los sprites:
	match CharactersData.characters[PlayerSession.character].name:
		"Alux":
			character = ALUX.instantiate()
		"Toh":
			character = ALUX.instantiate()
		"Keken":
			character = ALUX.instantiate()
		"Huolpoch":
			character = ALUX.instantiate()
		"Zotz":
			character = ALUX.instantiate()
		"Uaychivo":
			character = ALUX.instantiate()
		_:
			# Test debug (eliminar esta condicional):
			character = ALUX.instantiate()
	
	# Se añade el personaje a la escena:
	self.animated_sprite_2d.sprite_frames = character.sprite_frames
	self.animated_sprite_2d.animation = character.animation
	self.animated_sprite_2d.play("default")
	#self.add_child(character)
	#self.move_child(character, 2)
