extends Control

## Add text to print:
@export var text_to_print: String = ""
@onready var rich_text_label = $RichTextLabel


# Imprime una cadena:
func print_message(string: String) -> void:
	if !string.is_empty():
		rich_text_label.text = "[left]%s[/left]" %string
		rich_text_label.seconds = 0.1/2
		rich_text_label.move_text()


# Limpia el mensaje:
func clear_message() -> void:
	if !rich_text_label.text.is_empty():
		rich_text_label.text = "[left]%s[/left]" % "Pasa el cursor sobre una opción para ver más información."
		rich_text_label.seconds = 0.1/2
		rich_text_label.move_text()
	
