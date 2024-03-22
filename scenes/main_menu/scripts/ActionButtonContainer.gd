extends VBoxContainer

@onready var button1: Button = $Up
@onready var button2: Button = $Down
@onready var button3: Button = $Left
@onready var button4: Button = $Right
@onready var button5: Button = $Accept
@onready var button6: Button = $Pause
@onready var menu_textbox = $"../MenutTextboxContainer/MenuTextbox" # Textbox para errores.
var keyInputFlag: bool = true


func _process(_delta: float) -> void:
	# Se verifica si algún botón se presionó y está a la espera de un evento:
	if button1.is_processing_unhandled_key_input():
		disable_buttons([button2, button3, button4, button5, button6])
	elif button2.is_processing_unhandled_key_input():
		disable_buttons([button1, button3, button4, button5, button6])
	elif button3.is_processing_unhandled_key_input():
		disable_buttons([button1, button2, button4, button5, button6])
	elif button4.is_processing_unhandled_key_input():
		disable_buttons([button1, button2, button3, button5, button6])
	elif button5.is_processing_unhandled_key_input():
		disable_buttons([button1, button2, button3, button4, button6])
	elif button6.is_processing_unhandled_key_input():
		disable_buttons([button1, button2, button3, button4, button5])


func _unhandled_key_input(_event: InputEvent) -> void:
	menu_textbox.moving_text.seconds = 0
	# Manejo de errores:
	if button1.error:
		menu_textbox.print_message(button1.errorMsg, "c")
		button1.error = false
	elif button2.error:
		menu_textbox.print_message(button2.errorMsg, "c")
		button2.error = false
	elif button3.error:
		menu_textbox.print_message(button3.errorMsg, "c")
		button3.error = false
	elif button4.error:
		menu_textbox.print_message(button4.errorMsg, "c")
		button4.error = false
	elif button5.error:
		menu_textbox.print_message(button5.errorMsg, "c")
		button5.error = false
	elif button6.error:
		menu_textbox.print_message(button6.errorMsg, "c")
		button6.error = false
	
	# Se reactivan los botones una vez se remapeó una tecla:
	enable_buttons([button1, button2, button3, button4, button5, button6])
	keyInputFlag = true
	
	# Se borra el mensaje después de 20 segundos:
	menu_textbox.clear_message_after_time(20)


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
	
