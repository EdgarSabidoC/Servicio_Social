@tool
extends TextureButton

## Allows to drag a Texture2D. Extends TextureButton.
class_name DragTexture


## (x,y) coordinates for the element.
@onready var x_y_coordinates: Vector2i


func _get_drag_data(_at_position: Vector2) -> Variant:
	# Textura de la vista previa:
	var preview_texture = TextureButton.new()
	preview_texture.texture_normal = self.texture_normal # Se asigna la textura de la vista previa.
	preview_texture.size = Vector2(20, 20) # Tamaño de la vista previa.
	
	# Control para la vista previa:
	var preview = Control.new()
	preview.add_child(preview_texture) # Se asigna al control la textura de la vista previa.
	self.set_drag_preview(preview) # Se asigna el control.
	
	# Se asgina la posición de la vista previa para quedar el cursor centrado:
	preview_texture.position = preview_texture.get_local_mouse_position() - preview_texture.size/2
	
	# Se retorna la textura:
	return self.texture_normal
