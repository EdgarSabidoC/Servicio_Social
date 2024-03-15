extends Control

## Add text to print:
@export var text_to_print: String = ""
@onready var text = $Text


# Imprime una cadena:
func print_message(string: String) -> void:
	if !string.is_empty():
		text.text =   "[left]%s[/left]" %string


# Limpia el mensaje:
func clear_message() -> void:
	if !text.text.is_empty():
		text.text = "[left]%s[/left]" % "Pasa el cursor sobre una opción para ver más información."
	
