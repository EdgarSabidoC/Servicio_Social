extends Node

# Bandera del modo mouse:
@onready var mouse_mode_activated: bool = false

# Bandera de las acciones:
@onready var actions_enabled: bool = false

# Tipos de cursores del mouse:
@onready var cursor_arrow: CompressedTexture2D = load("res://assets/graphical_assets/mouse/mouse.png")

# Acciones de entrada:
@onready var input_actions = {"ui_up": InputMap.action_get_events("ui_up"),\
								"ui_down": InputMap.action_get_events("ui_down"),\
								"ui_left": InputMap.action_get_events("ui_left"), \
								"ui_right": InputMap.action_get_events("ui_right"), \
								"ui_accept": InputMap.action_get_events("ui_accept"), \
								"ui_cancel": InputMap.action_get_events("ui_cancel"), \
								"ui_pause": InputMap.action_get_events("ui_pause"), \
								"ui_focus_next": InputMap.action_get_events("ui_focus_next"), \
								"ui_focus_prev": InputMap.action_get_events("ui_focus_prev")}

const MOUSE: int = 0
const KEYBOARD: int = 1


func _ready() -> void:
	# Se configuran los cursores:
	# Cursor normal:
	Input.set_custom_mouse_cursor(self.cursor_arrow, Input.CURSOR_ARROW)
	# Cursor de mano apuntadora:
	Input.set_custom_mouse_cursor(self.cursor_arrow, Input.CURSOR_POINTING_HAND)
	# Cursor para arrastrar objetos (no disponible en Windows):
	Input.set_custom_mouse_cursor(self.cursor_arrow, Input.CURSOR_DRAG)
	# Cursor que se activa cuando se está arrastrando un objeto:
	Input.set_custom_mouse_cursor(self.cursor_arrow, Input.CURSOR_CAN_DROP)


func refresh_input_actions():
	input_actions = {
		"ui_up": InputMap.action_get_events("ui_up"),\
		"ui_down": InputMap.action_get_events("ui_down"),\
		"ui_left": InputMap.action_get_events("ui_left"), \
		"ui_right": InputMap.action_get_events("ui_right"), \
		"ui_accept": InputMap.action_get_events("ui_accept"), \
		"ui_cancel": InputMap.action_get_events("ui_cancel"), \
		"ui_pause": InputMap.action_get_events("ui_pause"), \
		"ui_focus_next": InputMap.action_get_events("ui_focus_next"), \
		"ui_focus_prev": InputMap.action_get_events("ui_focus_prev")
	}


# Función que cambia entre el modo teclado y modo mouse:
func change_mode() -> void:
	if not self.mouse_mode_activated:
		self.mouse_mode_activated = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		self.disable_actions()
	else:
		self.mouse_mode_activated = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		self.enable_actions()	
	

# Función que desactiva las acciones:
func disable_actions() -> void:
	self.actions_enabled = false
	for action in self.input_actions.keys():
		if action != "ui_pause":
			InputMap.action_erase_events(action)


# Desactiva una accción en específico:
func disable_action(action: String) -> void:
	if action in self.input_actions.keys():
		InputMap.action_erase_events(action)


# Activa una acción en específico:
func enable_action(action: String) -> void:
	for input_event in self.input_actions[action]:
		InputMap.action_add_event(action, input_event)


# Función que activa las acciones:
func enable_actions() -> void:
	self.actions_enabled = true
	for action in self.input_actions.keys():
		if action != "ui_pause":
			for input_event in self.input_actions[action]:
				InputMap.action_add_event(action, input_event)
