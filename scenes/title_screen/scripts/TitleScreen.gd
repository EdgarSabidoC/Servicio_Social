extends Control

@onready var rich_text_label_text_flash: RichTextLabelTextFlash = $RichTextLabelTextFlash
@export var _move_to: PackedScene
@onready var accept_key: String = "ui_accept"
@onready var pause_key: String = "ui_pause"
@onready var accept_texture: ActionIcon =  $ActionIcon
@onready var pause_texture: ActionIcon = $ActionIcon2
@onready var left_click_texture: ActionIcon = $ActionIcon3
@onready var accept_texture_path: String = "res://addons/ActionIcon/Keyboard/Enter.png"
@onready var pause_texture_path: String = "res://addons/ActionIcon/Keyboard/Space.png"
@onready var left_click_texture_path: String = "res://addons/ActionIcon/Mouse/Left.png"
@onready var accept: ActionIcon = ActionIcon.new()
@onready var pause: ActionIcon =  ActionIcon.new()
@onready var left_click: ActionIcon =  ActionIcon.new()
@export var accept_width: float = 0
@export var accept_height: float = 80
@export var pause_width: float = 0
@export var pause_height: float = 80
@export var left_click_width: float = 0
@export var left_click_height: float = 60


func _ready() -> void:
	assert(_move_to)
	
	accept.action_name = "ui_accept"
	pause.action_name = "ui_pause"
	# Se obtienen las imágenes de las acciones:
	accept_texture_path = accept._get_keyboard(InputMap.action_get_events("ui_accept")[0].keycode).get_path()
	pause_texture_path = pause._get_keyboard(InputMap.action_get_events("ui_pause")[0].keycode).get_path()
	rich_text_label_text_flash.text = "[center]Presiona [img={accept_width}x{accept_height}]{accept}[/img], presiona [img={pause_width}x{pause_height}]{pause}[/img] ".format({"accept_width": str(accept_width), "accept_height": str(accept_height), "accept": accept_texture_path, "pause_width": str(pause_width), "pause_height": str(pause_height), "pause": pause_texture_path})
	accept.refresh()
	pause.refresh()
	left_click.action_name  = "m1"
	left_click_texture_path = left_click._get_mouse(InputMap.action_get_events("m1")[0].button_index).get_path()
	rich_text_label_text_flash.text += "o presiona [img={left_click_width}x{left_click_height}]{left_click}[/img] para continuar[/center]".format({"left_click_width": str(left_click_width), "left_click_height": str(left_click_height), "left_click": left_click_texture_path})
	left_click.refresh()
	# Se cambia el tamaño de la fuente a 22px:
	rich_text_label_text_flash.add_theme_font_size_override("normal_font_size", 22)
	
	


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(accept_key) or Input.is_action_just_pressed(pause_key) or Input.is_action_just_pressed("m1"):
		Sfx.play_sound(Sfx.Sounds.SCREEN_PRESS)
		# Consume el evento:
		get_viewport().set_input_as_handled()
		rich_text_label_text_flash.speed = 60
		
		# Espera un poco para visualizar el efecto del parpadeo de la etiqueta:
		await get_tree().create_timer(0.5).timeout
		
		# Comienza la animación de desvanecimiento y cambia de escena al final de la animación:
		SceneTransition.change_scene(_move_to, "dissolve")
		
		# Se vuelve a activar el mouse:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
