extends VBoxContainer

@onready var button1: Button = $ActionButton
@onready var button2: Button = $ActionButton2
@onready var button3: Button = $ActionButton3
@onready var button4: Button = $ActionButton4
@onready var button5: Button = $ActionButton5
var keyInputFlag: bool = true

func _process(_delta: float) -> void:
	# Se verifica si algún botón se presionó y está a la espera de un evento:
	if button1.is_processing_unhandled_key_input():
		disable_buttons([button2, button3, button4, button5])
	elif button2.is_processing_unhandled_key_input():
		disable_buttons([button1, button3, button4, button5])
	elif button3.is_processing_unhandled_key_input():
		disable_buttons([button1, button2, button4, button5])
	elif button4.is_processing_unhandled_key_input():
		disable_buttons([button1, button2, button3, button5])
	elif button5.is_processing_unhandled_key_input():
		disable_buttons([button1, button2, button3, button4])


func _unhandled_key_input(_event: InputEvent) -> void:
	# Se reactivan los botones una vez se remapeó una tecla:
	enable_buttons([button1, button2, button3, button4, button5])
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
	
