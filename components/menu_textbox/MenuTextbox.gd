extends Control

# Add text to print:
@onready var moving_text = $MovingText
@export var default_text = ""


func _ready() -> void:
	print_message(default_text, "l")


# Imprime una cadena que se la pase y la alineación [l: left, c: center, r: right, f: fill]:
func print_message(string: String, alignment: String) -> void:
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
		moving_text.text = self.default_text
		moving_text.move_text()


# Limpia el mensaje después de que haya pasado una cantidad de segundos especificada:
func clear_message_after_time(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout # Espera un determinado tiempo en segundos
	clear_message()
