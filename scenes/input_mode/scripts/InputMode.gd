extends Control

@export var _move_to: PackedScene
@onready var keyboard_mode: Button = $VBoxContainer/HBoxContainer/KeyboardMode


func _ready() -> void:
	assert(_move_to)
	keyboard_mode.grab_focus()
	


# Activa el modo teclado:
func _on_keyboard_mode_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Mouse.enable_actions()
	# Comienza la animación de desvanecimiento y cambia de escena al final de la animación:
	SceneTransition.change_scene(_move_to, "dissolve")


# Activa el modo ratón:
func _on_mouse_mode_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Mouse.disable_actions()
	Mouse.change_mode()
	# Comienza la animación de desvanecimiento y cambia de escena al final de la animación:
	SceneTransition.change_scene(_move_to, "dissolve")
	
