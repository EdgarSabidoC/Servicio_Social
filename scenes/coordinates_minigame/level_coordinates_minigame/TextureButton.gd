extends TextureButton

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Texture2D


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	self.texture_normal = data
	self.dragging = false
	print_debug("Data dropped: %s" %self.dragging)
