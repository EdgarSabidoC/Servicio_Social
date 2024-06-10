extends Control

@onready var rich_text_label_text_flash: RichTextLabelTextFlash = $RichTextLabelTextFlash
@export var _move_to: PackedScene
@onready var accept_key: String = "ui_accept"
@onready var pause_key: String = "ui_pause"
@onready var ENTER: String = "res://addons/ActionIcon/Keyboard/Enter.png"
@onready var SPACE: String = "res://addons/ActionIcon/Keyboard/Space.png"

func _ready() -> void:
	assert(_move_to)
	rich_text_label_text_flash.text = "[center]Presiona la tecla [img]%s[/img] o la tecla [img]%s[/img] para continuar[/center]" %[ENTER, SPACE]
	


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(accept_key) or Input.is_action_just_pressed(pause_key):
		# Consume el evento:
		get_viewport().set_input_as_handled()
		rich_text_label_text_flash.speed = 60
		# Espera un poco para visualizar el efecto del parpadeo de la etiqueta:
		await get_tree().create_timer(0.5).timeout
		# Comienza la animación de desvanecimiento y cambia de escena al final de la animación:
		SceneTransition.change_scene(_move_to, "dissolve")
