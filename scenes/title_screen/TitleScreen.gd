extends Control

@export var _move_to: PackedScene

func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) \
	|| Input.is_key_pressed(KEY_SPACE) \
	|| Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_packed(_move_to)
