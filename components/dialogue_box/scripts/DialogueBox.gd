extends Control

@onready var moving_text = $CanvasLayer/MarginContainer/MovingText
@export var alignment = "f"
@onready var margin_container = $CanvasLayer/MarginContainer
var eof: bool = false
var paragraphs = "[p]Esta es una línea de texto.Esta es otra línea de texto.[/p][p]Segundo párrafo.[/p]".replace("[/p]", "").split("[p]")
var len: int
var current_p: int = 0

func _ready() -> void:
	if paragraphs[current_p] == "":
		current_p += 1
	print_message(paragraphs[current_p])
	len = len(paragraphs)-1

func _process(_delta: float) -> void:
	if paragraphs[current_p] == "":
		current_p += 1
	if Input.is_action_pressed("ui_accept") and !eof:
		moving_text.seconds = 0.05/4
	elif Input.is_action_just_pressed("ui_accept") and eof:
		print_debug("Finalizó un párrafo")
		if current_p < len:
			current_p += 1
			# Se imprime el siguiente párrafo:
			print_message(paragraphs[current_p])
		eof = false
	else:
		moving_text.seconds = 0.1/2


# Imprime una cadena que se la pase y la alineación [l: left, c: center, r: right, f: fill]:
func print_message(string: String) -> void:
	match alignment:
		"l":
			moving_text.text = "[left]%s[/left]" %string
		"c":	
			moving_text.text = "[center]%s[/center]" %string
		"r":
			moving_text.text = "[right]%s[/right]" %string
		"f":
			moving_text.text = "[fill]%s[/fill]" %string
	moving_text.move_text()


# Limpia el mensaje (imprime una cadena predeterminada):
func clear_message() -> void:
	if !moving_text.text.is_empty():
		moving_text.text = self.text
		moving_text.move_text()


func print_message_by_paragraph(paragraph: String) -> void:
	match alignment:
		"l":
			moving_text.text = "[left]%s[/left]" % paragraph
		"c":	
			moving_text.text = "[center]%s[/center]" % paragraph
		"r":
			moving_text.text = "[right]%s[/right]" % paragraph
		"f":
			moving_text.text = "[fill]%s[/fill]" % paragraph
	moving_text.move_text()
