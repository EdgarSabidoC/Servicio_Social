extends HBoxContainer

@onready var play: Button = $MainMenu/Play
@onready var options: Button = $MainMenu/Options
@onready var quit: Button = $MainMenu/Quit
@onready var menu_textbox: Control = $MenuTextbox/MenuTextbox
var current_button: Button = null


func _process(_delta) -> void:
	var new_button: Button = get_hovered_button()

	# Solo actualiza el mensaje si el botón actual es diferente al anterior:
	if new_button != current_button:
		current_button = new_button
		update_message()


# Retorna un Button:
func get_hovered_button() -> Button:
	# Lógica para determinar sobre qué botón está el cursor:
	if play.is_hovered():
		return play
	elif options.is_hovered():
		return options
	elif quit.is_hovered():
		return quit
	else:
		return null


func update_message() -> void:
	if current_button != null:
		# Si hay un botón actualmente:
		menu_textbox.print_message(current_button.hint)
	else:
		# Si no, se limpia el mensaje:
		menu_textbox.clear_message()
