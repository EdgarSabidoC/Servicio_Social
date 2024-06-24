extends TextureButton

var dragging: bool = false # Indica si se está arrastrando
var of = Vector2(0,0)


func _process(_delta: float) -> void:
	#if self.dragging:
		#self.position = self.get_global_mouse_position() - self.of
	pass


func _get_drag_data(_at_position: Vector2) -> Variant:
	var preview_texture = TextureButton.new()
	self.dragging = true
	preview_texture.texture_normal = self.texture_normal
	preview_texture.size = Vector2(30, 30)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	self.set_drag_preview(preview)
	
	preview_texture.position = preview_texture.get_local_mouse_position() - preview_texture.size/2
	
	return self.texture_normal

#
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Texture2D


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	self.texture_normal = data
	self.dragging = false
	print_debug("Data dropped: %s" %self.dragging)


#func _on_button_up() -> void:
	#self.dragging = false
#
#
#func _on_button_down() -> void:
	#self.dragging = true
	#self.of = self.get_global_mouse_position() - global_position
