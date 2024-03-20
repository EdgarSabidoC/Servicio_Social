extends RichTextLabel

@export var seconds: float = 0.1/2

func _ready() -> void:
	move_text()

# Realiza el efecto de movimiento de los caracteres del texto:
func move_text() -> void:
	self.visible_characters = 0 # Contador de char visible
	
	# Se van mostrando los chars de la propiedad text:
	for i in self.get_parsed_text():
		self.visible_characters += 1 # Aumenta el char visible
		await get_tree().create_timer(seconds).timeout # Espera un determinado tiempo entre chars
