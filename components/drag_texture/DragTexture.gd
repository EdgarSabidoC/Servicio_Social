@tool
extends AnimatedTextureRect

## Allows to drag a Texture2D, preview animation can be set on Sprites from AnimatedTextureRect.
## Extends AnimatedTextureRect.
## AnimatedTextureRect animation has higher precedence than Texture from TextureRect.
## Auto play and Playing are disabled by default on Preview mode.
class_name DragTexture


## (x,y) coordinates for the element
@onready var x_y_coordinates: Vector2i

enum AnimationOptions {## Options to use the Sprites animation as preview, texture or both
						PREVIEW = 0, ## Preview mode active
						TEXTURE = 1, ## Texture mode active
						BOTH = 2, ## Preview and Texture modes active
						}
## Options for using Sprites from SpriteFrames (AnimatedTextureRect) as preview or texture
@export var animation_as: AnimationOptions = self.AnimationOptions.PREVIEW

## Size of preview animation or texture
@export var preview_size: Vector2 = Vector2(50, 50)


func _ready() -> void:
	if self.animation_as == self.AnimationOptions.BOTH or self.animation_as == self.AnimationOptions.TEXTURE:
		# Si es modo Texture o Both se reproduce la animación:
		self.play()
	else:
		# Si es el modo preview se para la animación:
		self.auto_play = false
		self.stop()


func _get_drag_data(_at_position: Vector2) -> Variant:
	# Textura de la vista previa:
	var preview_texture =  AnimatedTextureRect.new()
	
	# Se valida si hay sprites y si es modo Preview o Both:
	if self.sprites and (self.animation_as == AnimationOptions.PREVIEW or self.animation_as == AnimationOptions.BOTH):
		preview_texture.sprites = self.sprites
		preview_texture.play()
	else:
		# Si es modo texture o no hay sprites:
		preview_texture.texture = self.texture # Se asigna la textura de la vista previa.
	preview_texture.expand_mode = EXPAND_IGNORE_SIZE
	preview_texture.size = self.preview_size

	# Control para la vista previa:
	var preview = Control.new()
	preview.add_child(preview_texture) # Se asigna al control la textura de la vista previa.
	self.set_drag_preview(preview) # Se asigna el control.
	
	# Se asgina la posición de la vista previa para quedar el cursor centrado:
	preview_texture.position = preview_texture.get_local_mouse_position() - preview_texture.size/2
	
	# Se retorna la textura:
	return self.texture
