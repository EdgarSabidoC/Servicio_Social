extends Control

@onready var label = $Label
@export var _move_to: PackedScene = preload("res://scenes/main_menu/MainScene.tscn")

func _ready() -> void:
	assert(_move_to)


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_ENTER):
		# Consume el evento:
		get_viewport().set_input_as_handled()
		label.speed = 60
		# Espera un poco para visualizar el efecto del parpadeo de la etiqueta:
		await get_tree().create_timer(0.5).timeout
		# Comienza la animación de desvanecimiento y cambia de escena al final de la animación:
		SceneTransition.change_scene(_move_to, "dissolve")
