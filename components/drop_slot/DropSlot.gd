@tool
extends TextureButton

##  Permite la mecánica de soltar una Texture2D. Extiende a TextureButton.
class_name DropSlot


@onready var coordinates_x_y: Vector2i


signal dropped


# Se valida que se pueda soltar una Texture2D:
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Texture2D


# La texture_normal se convierte en la textura que le es pasada:
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	self.texture_normal = data
	dropped.emit()
