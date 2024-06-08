extends Control

@onready var label = $Label
@export var _move_to: PackedScene


func _ready() -> void:
	assert(_move_to)


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_ENTER):
		# Consume el evento:
		get_viewport().set_input_as_handled()
		label.speed = 60
		await get_tree().create_timer(0.5).timeout
		# Comienza la animación de desvanecimiento y cambia de escena al final de la animación:
		change_scene()


# Función asíncrona que inicia el desvanecimiento y cambia de escena al final de la animación:
func change_scene() -> void:
	# Cambia a la nueva escena
	get_tree().change_scene_to_packed(_move_to)
