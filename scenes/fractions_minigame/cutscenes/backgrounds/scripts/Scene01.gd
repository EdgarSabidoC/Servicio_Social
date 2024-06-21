extends Control

const ALUX = preload("res://components/characters/alux/Alux.tscn")
const HUOLPOCH = preload("res://components/characters/huolpoch/Huolpoch.tscn")
const KEKEN = preload("res://components/characters/keken/Keken.tscn")
const TOH = preload("res://components/characters/toh/Toh.tscn")
const UAYCHIVO = preload("res://components/characters/uaychivo/Uaychivo.tscn")
const ZOTZ = preload("res://components/characters/zotz/Zotz.tscn")
@onready var dialogue_box: Control = $DialogueBox
@onready var character: AnimatedTextureRect


func _ready() -> void:
	# Se inicializan los sprites:
	match CharactersData.characters[PlayerSession.character].name:
		#"Alux":
			#character = ALUX.instantiate()
		#"Toh":
			#character = TOH.instantiate()
		#"Keken":
			#character = KEKEN.instantiate()
		#"Huolpoch":
			#character = HUOLPOCH.instantiate()
		#"Zotz":
			#character = ZOTZ.instantiate()
		#"Uaychivo":
			#character = UAYCHIVO.instantiate()
		_:
			# Test debug (eliminar esta condicional):
			character = ZOTZ.instantiate()
	# Se escala el personaje:
	character.scale = Vector2(1.5,1.5)
	
	# Se añade el personaje a la escena:
	self.add_child(character)
	self.move_child(character, 2)
	
	# Se conecta la señal de animation changed a la función de start_dialogue_box:
	character.connect("animation_changed", self.start_dialogue_box)


# Inicia la caja de diálogos:
func start_dialogue_box() -> void:
	# Se activa la caja de diálogo después de la animación de entrada:
	dialogue_box.start()
