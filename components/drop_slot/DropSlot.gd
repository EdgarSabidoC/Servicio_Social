@tool
extends AnimatedTextureRect

##  Allows to drop a Texture2D. Extends AnimatedTextureRect.
class_name DropSlot


## (x,y) coordinates for the element.
@onready var x_y_coordinates: Vector2i


## Dropped signal is emitted when a texture is dropped inside the slot.
signal dropped


# Se valida que se pueda soltar una Texture2D:
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Texture2D


# La texture se convierte en la textura que se le suelta:
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	self.texture = data
	dropped.emit()
