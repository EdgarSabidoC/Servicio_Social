extends Button

@export var action: String = "ui_up" # Acción predeterminada
var error: bool = false
var errorMsg: String = ""

var actions: Array[String] = ["ui_up", "ui_down", "ui_left", "ui_right", "ui_accept", "ui_cancel"]

func _ready() -> void:
	set_process_unhandled_key_input(false)
	display_key()


# Muestra el texto de la tecla seleccionada:
func display_key() -> void:
	text = InputMap.action_get_events(action)[0].as_text()


# Remapea la tecla borrando el evento previo y añadiendo uno nuevo:
func remap_action_to(event: InputEvent) -> void:

	# Se verifica que la tecla ingresada no esté repetida:
	var old_key: InputEventKey = Persistence.config.get_value("Controls", action, InputEventKey)
	for a in actions:
		var compare_key: InputEventKey = Persistence.config.get_value("Controls", a, InputEventKey)
		# Si las cciones son diferentes, pero tienen la misma tecla, se intercambian:
		if a != action && compare_key.keycode == event.keycode:
			text = old_key.as_text()
			errorMsg = "No es posible asignar " + InputMap.action_get_events(a)[0].as_text() + " debido a que ya se encuentra asignada."
			error = true
			return
	
	# Se configura action y event para la sección Controls
	# y se guarda la información.
	errorMsg = ""
	error = false
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)
	Persistence.config.set_value("Controls", action, event)
	Persistence.save_data()
	
	text = event.as_text()


# Enciende el proceso de la tecla y cambia el texto:
func _on_pressed() -> void:
	set_process_unhandled_key_input(true)
	text = "Presiona cualquier tecla"


# Para una tecla sin manejo, remapea a un nuevo evento, configura el
# proceso de tecla a falso y suelta la tecla.
func _unhandled_key_input(event: InputEvent) -> void:
	remap_action_to(event)
	set_process_unhandled_key_input(false)
	release_focus()
