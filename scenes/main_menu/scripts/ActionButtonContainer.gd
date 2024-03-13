extends VBoxContainer

@onready var button1: Button = $Up
@onready var button2: Button = $Down
@onready var button3: Button = $Left
@onready var button4: Button = $Right
@onready var button5: Button = $Accept
@onready var button6: Button = $Pause
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
	# Se reactivan los botones una vez se remapeó una tecla:
	enable_buttons([button1, button2, button3, button4, button5, button6])
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
	
