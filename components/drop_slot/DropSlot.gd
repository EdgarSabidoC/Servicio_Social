#@tool
extends AnimatedTextureRect

## (x,y) coordinates for the element.
@export var coordinates: Vector2i

## TextureRect used as background.
@onready var texture_rect: TextureRect = $TextureRect


## Dropped signal is emitted when a texture is dropped inside the slot.
signal texture_dropped(coordinates: Vector2i)


func clear_texture() -> void:
	if self.texture:
		self.texture = null


# Se valida que se pueda soltar una Texture2D:
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Texture2D


# La texture se convierte en la textura que se le suelta:
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	self.texture = data
	emit_signal("texture_dropped", self.coordinates)
