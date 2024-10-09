extends Button

class_name ActionButton

@export var action: String = "ui_up" # Acción predeterminada
var error: bool = false
var errorMsg: String = ""
@onready var action_icon: ActionIcon = $ActionIcon
var actions: Array[String] = ["ui_up", "ui_down", "ui_left", "ui_right", "ui_accept", "ui_pause"]

func _ready() -> void:
	set_process_unhandled_key_input(false)
	display_key()


# Muestra el texto de la tecla seleccionada:
func display_key() -> void:
	self.action_icon.action_name = self.action


func _display_key_when_error(a) -> String:
	return self.action_icon._get_keyboard(Mouse.input_actions[a][0].keycode).get_path()


# Remapea la tecla borrando el evento previo y añadiendo uno nuevo:
func _remap_action_to(event: InputEvent) -> bool:
	# Se borra el texto de la tecla:
	text = ""
	# Se verifica que la tecla ingresada no esté repetida:
	for a in self.actions:
		var compare_key: InputEventKey = Persistence.config.get_value("Controls", a, InputEventKey)
		# Si las acciones son diferentes, pero tienen la misma tecla, se arroja un error:
		if event.keycode == KEY_ESCAPE or (a != self.action and compare_key.keycode == event.keycode):
			# Se refresca el ícono del botón de acción:
			self.action_icon.refresh()
			# Se muestra el ícono del botón de acción:
			self.action_icon.show()
			# Se obtiene la tecla del error:
			var error_image: String = _display_key_when_error(a)
			self.errorMsg = "No es posible asignar «[img={error_width}x{error_height}]{error_image}[/img]» debido a que ya se encuentra asignada.".format({"error_width": 0, "error_height": 40, "error_image": error_image})
			self.error = true
			return false
	
	# Se configura action y event para la sección Controls
	# y se guarda la información.
	self.errorMsg = ""
	self.error = false
	InputMap.action_erase_events(self.action)
	InputMap.action_add_event(self.action, event)
	Persistence.config.set_value("Controls", self.action, event)
	Persistence.save_data()
	Mouse.refresh_input_actions()
	# Se refresca el ícono del botón de acción:
	self.action_icon.refresh()
	# Se muestra el ícono del botón de acción:
	self.action_icon.show()
	
	Sfx.play_sound(Sfx.Sounds.BUTTON_REMAP)
	
	return true

# Enciende el proceso de la tecla y cambia el texto:
func _on_pressed() -> void:
	self.release_focus() # Se quita el enfoque en el botón
	# Evita que al presionar enter se propague el evento:
	get_tree().get_root().set_input_as_handled()
	
	# Se activa la escucha para el proceso de entrada de teclado:
	set_process_unhandled_key_input(true)
	self.action_icon.hide() # Se oculta el ícono del botón de acción
	text = "Presiona cualquier tecla"


# Para una tecla sin manejo, remapea a un nuevo evento, configura el
# proceso de tecla a falso.
func _unhandled_key_input(event: InputEvent) -> void:
	_remap_action_to(event) # Remapea la acción	
	set_process_unhandled_key_input(false) # Se para de escuchar el evento de teclado.
	await get_tree().create_timer(0.5).timeout
	self.grab_focus() # Se enfoca el botón


func _on_focus_entered() -> void:
	if not get_viewport().is_processing_unhandled_input():
		Sfx.play_sound(Sfx.Sounds.KEY_PRESS)
