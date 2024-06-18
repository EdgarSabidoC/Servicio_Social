extends Node

# Bandera del modo mouse:
@onready var mouse_mode_activated: bool = true
# Bandera de las acciones:
@onready var actions_enabled: bool = false

# Punteros del mouse:
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


func _ready() -> void:
	Input.set_custom_mouse_cursor(cursor_arrow, Input.CURSOR_ARROW)


# Función que cambia entre el modo teclado y modo mouse:
func change_mode() -> void:
	self.mouse_mode_activated = !self.mouse_mode_activated
	
	if !self.mouse_mode_activated:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		self.enable_actions()
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		self.disable_actions()
	

# Función que desactiva las acciones:
func disable_actions() -> void:
	self.actions_enabled = false
	for action in input_actions.keys():
		if action != "ui_pause":
			InputMap.action_erase_events(action)


# Función que activa las acciones:
func enable_actions() -> void:
	self.actions_enabled = true
	for action in input_actions.keys():
		if action != "ui_pause":
			for input_event in input_actions[action]:
				InputMap.action_add_event(action, input_event)
