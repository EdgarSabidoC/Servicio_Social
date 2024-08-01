extends VBoxContainer

@onready var up_button: ActionButton = $Up
@onready var down_button: ActionButton = $Down
@onready var left_button: ActionButton = $Left
@onready var right_button: ActionButton = $Right
@onready var accept_button: ActionButton = $Accept
@onready var pause_button: ActionButton = $Pause
@onready var menu_textbox = $"./../../../MenuTextboxContainer/MenuTextbox" # Textbox para errores.

var time_to_clear: int = 5 # Variable que controla el tiempo en (segundos) para borrar el mensaje de error del textbox.
var keyInputFlag: bool = true


func _process(_delta: float) -> void:
	# Se verifica si algún botón se presionó y está a la espera de un evento:
	if self.up_button.is_processing_unhandled_key_input():
		disable_buttons([self.down_button, self.left_button, self.right_button, self.accept_button, self.pause_button])
	elif self.down_button.is_processing_unhandled_key_input():
		disable_buttons([self.up_button, self.left_button, self.right_button, self.accept_button, self.pause_button])
	elif self.left_button.is_processing_unhandled_key_input():
		disable_buttons([self.up_button, self.down_button, self.right_button, self.accept_button, self.pause_button])
	elif self.right_button.is_processing_unhandled_key_input():
		disable_buttons([self.up_button, self.down_button, self.left_button, self.accept_button, self.pause_button])
	elif self.accept_button.is_processing_unhandled_key_input():
		disable_buttons([self.up_button, self.down_button, self.left_button, self.right_button, self.pause_button])
	elif self.pause_button.is_processing_unhandled_key_input():
		disable_buttons([self.up_button, self.down_button, self.left_button, self.right_button, self.accept_button])


func _unhandled_key_input(_event: InputEvent) -> void:
	self.menu_textbox.moving_text.seconds = 0

	# Manejo de errores:
	if self.up_button.error:
		self.menu_textbox.print_message(self.up_button.errorMsg, "c")
		self.up_button.error = false
		# Se borra el mensaje después de una cantidad de segundos:
		self.menu_textbox.clear_message_after_time(self.time_to_clear)
	elif self.down_button.error:
		self.menu_textbox.print_message(self.down_button.errorMsg, "c")
		self.down_button.error = false
		# Se borra el mensaje después de una cantidad de segundos:
		self.menu_textbox.clear_message_after_time(self.time_to_clear)
	elif self.left_button.error:
		self.menu_textbox.print_message(self.left_button.errorMsg, "c")
		self.left_button.error = false
		# Se borra el mensaje después de una cantidad de segundos:
		self.menu_textbox.clear_message_after_time(self.time_to_clear)
	elif self.right_button.error:
		self.menu_textbox.print_message(self.right_button.errorMsg, "c")
		self.right_button.error = false
		# Se borra el mensaje después de una cantidad de segundos:
		self.menu_textbox.clear_message_after_time(self.time_to_clear)
	elif self.accept_button.error:
		self.menu_textbox.print_message(self.accept_button.errorMsg, "c")
		self.accept_button.error = false
		# Se borra el mensaje después de una cantidad de segundos:
		self.menu_textbox.clear_message_after_time(self.time_to_clear)
	elif self.pause_button.error:
		self.menu_textbox.print_message(self.pause_button.errorMsg, "c")
		self.pause_button.error = false
		# Se borra el mensaje después de una cantidad de segundos:
		self.menu_textbox.clear_message_after_time(self.time_to_clear)
		
	# Se reactivan los botones una vez se remapeó una tecla:
	enable_buttons([self.up_button, self.down_button, self.left_button, self.right_button, self.accept_button, self.pause_button])
	
	self.keyInputFlag = true


# Desactiva los botones:
func disable_buttons(buttons: Array) -> void:
	if self.keyInputFlag:
		for i in buttons.size():
			buttons[i].disabled = true
			
		self.keyInputFlag = false


# Activa los botones:
func enable_buttons(buttons: Array) -> void:
	for i in buttons.size():
		buttons[i].disabled = false
