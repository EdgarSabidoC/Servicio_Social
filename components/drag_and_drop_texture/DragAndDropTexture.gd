extends TextureRect

var dragging: bool = false # Indica si se está arrastrando
var of = Vector2(0,0) # Offset

func _input(_event: InputEvent) -> void:
	pass


func _process(_delta: float):
	if self.dragging:
		self.position = self.get_global_mouse_position() - self.of
	
	# Si se llega a quedar en el estado de arrastrar, se puede dar click:
	if Input.is_action_just_pressed("m1") and self.dragging:
		self.dragging = false
		

func _get_drag_data(_at_position: Vector2) -> Variant:
	#var preview_texture = TextureRect.new()
	self.of = self.get_global_mouse_position() - global_position
	self.dragging = true
	#preview_texture.texture = self.texture
	#preview_texture.expand_mode = 1
	#preview_texture.size = Vector2(30, 30)
	#
	#var preview = Control.new()
	#preview.add_child(preview_texture)
	#
	#set_drag_preview(preview)

	return self.texture


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Texture2D


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	self.texture = data
	self.dragging = false
