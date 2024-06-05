extends Control

@export var _move_to: PackedScene

func _ready() -> void:
	assert(_move_to)

# Activa el modo teclado:
func _on_keyboard_mode_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Mouse.enable_actions()
	Mouse.change_mode()
	# Cambia a la nueva escena:
	change_scene()

# Activa el modo ratón:
func _on_mouse_mode_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Mouse.disable_actions()
	Mouse.change_mode()
	# Cambia a la nueva escena:
	change_scene()


func change_scene() -> void:
	# Cambia a la nueva escena
	get_tree().change_scene_to_packed(_move_to)
