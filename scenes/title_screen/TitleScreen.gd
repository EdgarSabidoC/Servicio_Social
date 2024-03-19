extends Control
@onready var texture_rect = $TextureRect
#@export var _move_to: PackedScene
@onready var menu_container = $"../MenuContainer"
@onready var menu_background_color = $"../MenuBackgroundColor"
@onready var label = $Label

func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE) \
	|| Input.is_key_pressed(KEY_ENTER):
		label.hide()
		texture_rect.fade_out()
		waitToHide(1)


# Función que espera para ocltar el componente:
func waitToHide(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	self.queue_free()
