extends Control

@onready var color_rect: ColorRect = $ColorRect
@onready var label = $Label
@export var _move_to: PackedScene


func _ready() -> void:
	assert(_move_to)
	
	# Se cargan los datos de los personajes (nombre, bonus, defeated y assets) y se añade el nodo en el árbol:
	var LoadData = load("res://scripts/autoloads/data/json_data/CharactersData.gd").new()
	LoadData.name = "CharactersData"
	get_tree().root.add_child.call_deferred(LoadData)


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_ENTER):
		# Consume el evento:
		get_viewport().set_input_as_handled()
		label.speed = 60
		await get_tree().create_timer(0.5).timeout
		# Comienza la animación de desvanecimiento y cambia de escena al final de la animación:
		await fade_out_and_change_scene()


# Función asíncrona que inicia el desvanecimiento y cambia de escena al final de la animación:
func fade_out_and_change_scene() -> void:
	# Reproduce la animación de desvanecimiento del TextureRect
	await color_rect.fade_out()
	# Cambia a la nueva escena
	get_tree().change_scene_to_packed(_move_to)
