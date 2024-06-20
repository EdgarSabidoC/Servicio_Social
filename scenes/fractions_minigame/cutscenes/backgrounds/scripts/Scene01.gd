extends Control

const ALUX = preload("res://components/characters/alux/Alux.tscn")
const HUOLPOCH = preload("res://components/characters/huolpoch/Huolpoch.tscn")
const KEKEN = preload("res://components/characters/keken/Keken.tscn")
const TOH = preload("res://components/characters/toh/Toh.tscn")
const UAYCHIVO = preload("res://components/characters/uaychivo/Uaychivo.tscn")
const ZOTZ = preload("res://components/characters/zotz/Zotz.tscn")


func _ready() -> void:
	var character: AnimatedTextureRect
	# Se inicializan los sprites:
	match CharactersData.characters[PlayerSession.character].name:
		"Alux":
			character = ALUX.instantiate()
		"Toh":
			character = TOH.instantiate()
		"Keken":
			character = KEKEN.instantiate()
		"Huolpoch":
			character = HUOLPOCH.instantiate()
		"Zotz":
			character = ZOTZ.instantiate()
		"Uaychivo":
			character = UAYCHIVO.instantiate()
		_:
			# Test debug (eliminar esta condicional):
			character = ALUX.instantiate()
	# Se añade el personaje a la escena:
	self.add_child(character)
	self.move_child(character, 2)
