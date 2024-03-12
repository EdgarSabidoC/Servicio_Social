extends Control

## Add text to print:
@export var text_to_print: String = ""

@onready var text: RichTextLabel = $Panel/Text


func print_message(string: String) -> void:
	if !string.is_empty():
		text.text = string


func clear_message() -> void:
	if !text.text.is_empty():
		text.text = "Pasa el cursor encima de una opción para más información."
	
