extends Button

@export var action: String = "ui_up"

func _ready() -> void:
	set_process_unhandled_key_input(false)
	display_key()


# Muestra el texto de la tecla seleccionada:
func display_key() -> void:
	text = InputMap.action_get_events(action)[0].as_text()


# Remapea la tecla borrando el evento previo y añadiendo uno nuevo:
func remap_action_to(event: InputEvent) -> void:
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)
	
	# Se configura action y event para la sección Controls
	# y se guarda la información.
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
