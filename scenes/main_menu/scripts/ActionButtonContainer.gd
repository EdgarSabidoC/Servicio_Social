extends VBoxContainer

@onready var up_button: Button = $Up
@onready var down_button: Button = $Down
@onready var left_button: Button = $Left
@onready var right_button: Button = $Right
@onready var accept_button: Button = $Accept
@onready var pause_button: Button = $Pause
@onready var back_button = $"../../../../BackButton"
@onready var menu_textbox = $"../MenuTextboxContainer/MenuTextbox" # Textbox para errores.
var time_to_clear: int = 5 # Variable que controla el tiempo en (segundos) para borrar el mensaje de error del textbox.
var keyInputFlag: bool = true


func _process(_delta: float) -> void:
	# Se verifica si algún botón se presionó y está a la espera de un evento:
	if up_button.is_processing_unhandled_key_input():
		disable_buttons([down_button, left_button, right_button, accept_button, pause_button, back_button])
	elif down_button.is_processing_unhandled_key_input():
		disable_buttons([up_button, left_button, right_button, accept_button, pause_button, back_button])
	elif left_button.is_processing_unhandled_key_input():
		disable_buttons([up_button, down_button, right_button, accept_button, pause_button, back_button])
	elif right_button.is_processing_unhandled_key_input():
		disable_buttons([up_button, down_button, left_button, accept_button, pause_button, back_button])
	elif accept_button.is_processing_unhandled_key_input():
		disable_buttons([up_button, down_button, left_button, right_button, pause_button, back_button])
	elif pause_button.is_processing_unhandled_key_input():
		disable_buttons([up_button, down_button, left_button, right_button, accept_button, back_button])


func _unhandled_key_input(_event: InputEvent) -> void:
	menu_textbox.moving_text.seconds = 0

	# Manejo de errores:
	if up_button.error:
		menu_textbox.print_message(up_button.errorMsg)
		up_button.error = false
		# Se borra el mensaje después de una cantidad de segundos:
		menu_textbox.clear_message_after_time(time_to_clear)
	elif down_button.error:
		menu_textbox.print_message(down_button.errorMsg)
		down_button.error = false
		# Se borra el mensaje después de una cantidad de segundos:
		menu_textbox.clear_message_after_time(time_to_clear)
	elif left_button.error:
		menu_textbox.print_message(left_button.errorMsg)
		left_button.error = false
		# Se borra el mensaje después de una cantidad de segundos:
		menu_textbox.clear_message_after_time(time_to_clear)
	elif right_button.error:
		menu_textbox.print_message(right_button.errorMsg)
		right_button.error = false
		# Se borra el mensaje después de una cantidad de segundos:
		menu_textbox.clear_message_after_time(time_to_clear)
	elif accept_button.error:
		menu_textbox.print_message(accept_button.errorMsg)
		accept_button.error = false
		# Se borra el mensaje después de una cantidad de segundos:
		menu_textbox.clear_message_after_time(time_to_clear)
	elif pause_button.error:
		menu_textbox.print_message(pause_button.errorMsg)
		pause_button.error = false
		# Se borra el mensaje después de una cantidad de segundos:
		menu_textbox.clear_message_after_time(time_to_clear)
		
	# Se reactivan los botones una vez se remapeó una tecla:
	enable_buttons([up_button, down_button, left_button, right_button, accept_button, pause_button, back_button])
	keyInputFlag = true


# Desactiva los botones:
func disable_buttons(buttons: Array) -> void:
	if keyInputFlag:
		for i in buttons.size():
			buttons[i].disabled = true
			
		keyInputFlag = false


# Activa los botones:
func enable_buttons(buttons: Array) -> void:
	for i in buttons.size():
		buttons[i].disabled = false
