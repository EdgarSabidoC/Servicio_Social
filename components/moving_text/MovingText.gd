extends RichTextLabel

@export var seconds: float = 0.1/2

func _ready() -> void:
	move_text() # Permite que el nodo funcione desde que entra al árbol


# Realiza el efecto de movimiento de los caracteres del texto:
func move_text() -> void:
	self.visible_characters = 0 # Char visible
	
	# Se van mostrando los chars de la propiedad text:
	for i in self.get_parsed_text():
		self.visible_characters += 1 # Se muve al siguiente char visible
		await get_tree().create_timer(seconds).timeout # Espera un determinado tiempo entre chars
