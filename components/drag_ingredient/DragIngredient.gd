@tool
extends AnimatedTextureRect

## Allows to drag a Texture2D for an ingredient, preview animation can be set on
## Sprites from AnimatedTextureRect. Extends AnimatedTextureRect.
## AnimatedTextureRect animation has higher precedence than Texture from TextureRect.
## Auto play and Playing are disabled by default on Preview mode.
class_name DragIngredient


## (x,y) coordinates for the element
@export var coordinates: Vector2i

enum Ingredients {## Options of possible ingredients to use
					NULL=0,
					MUSHROOM=1,
					PEPPERONI=2,
					SALAMI=3,
					ONION=4,
					GREEN_PEPPER=5,
					HAM=6,
					FISH=7
				}
@export var ingredient_name: Ingredients

enum AnimationOptions {## Options to use the Sprites animation as preview, texture or both
						PREVIEW = 0, ## Preview mode active
						TEXTURE = 1, ## Texture mode active
						BOTH = 2, ## Preview and Texture modes active
						}
## Options for using Sprites from SpriteFrames (AnimatedTextureRect) as preview or texture
@export var animation_as: AnimationOptions = self.AnimationOptions.PREVIEW

## Size of preview animation or texture
@export var preview_size: Vector2 = Vector2(50, 50)

## Texture when the ingredient is on the pizza.
@export var texture_on_pizza: Texture2D


func _ready() -> void:
	if self.animation_as == self.AnimationOptions.BOTH or self.animation_as == self.AnimationOptions.TEXTURE:
		# Si es modo Texture o Both se reproduce la animación:
		self.play()
	else:
		# Si es el modo preview se para la animación:
		self.auto_play = false
		self.stop()
		self._load_ingredient_texture_for_pizza()


# Carga la textura del ingrediente cuando estará sobre la pizza (texture_on_pizza):
func _load_ingredient_texture_for_pizza() -> void:
	match self.ingredient_name:
		self.Ingredients.MUSHROOM:
			self.texture_on_pizza = load("res://assets/graphical_assets/environments/pizzas/mushroom.tga")
		self.Ingredients.PEPPERONI:
			self.texture_on_pizza = load("res://assets/graphical_assets/environments/pizzas/pepperoni.tga")
		self.Ingredients.SALAMI:
			self.texture_on_pizza = load("res://assets/graphical_assets/environments/pizzas/salami.tga")
		self.Ingredients.ONION:
			self.texture_on_pizza = load("res://assets/graphical_assets/environments/pizzas/onion.tga")
		self.Ingredients.GREEN_PEPPER:
			self.texture_on_pizza = load("res://assets/graphical_assets/environments/pizzas/green_pepper.tga")
		self.Ingredients.HAM:
			self.texture_on_pizza = load("res://assets/graphical_assets/environments/pizzas/ham.tga")
		self.Ingredients.FISH:
			self.texture_on_pizza = load("res://assets/graphical_assets/environments/pizzas/fish.tga")


func _get_drag_data(_at_position: Vector2) -> Variant:
	# Se oculta el mouse:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# Se reproduce el sonido:
	Sfx.play_sound(Sfx.Sounds.INGREDIENT_TAKE)
	
	# Textura de la vista previa:
	var preview_texture =  AnimatedTextureRect.new()
	
	# Se valida si hay sprites y si es modo Preview o Both:
	if self.sprites and (self.animation_as == AnimationOptions.PREVIEW or \
						self.animation_as == AnimationOptions.BOTH):
		# Se asigna la animación actual a la del preview:
		preview_texture.current_animation = self.current_animation
		preview_texture.sprites = self.sprites # Se asignan los sprites al preview
		preview_texture.play() # Se reproduce la animación
	else:
		# Si es modo texture o no hay sprites:
		preview_texture.texture = self.texture_on_pizza # Se asigna la textura de la vista previa.
	
	# Se cambia el tamaño de la textura del preview:
	preview_texture.expand_mode = EXPAND_IGNORE_SIZE
	preview_texture.size = self.preview_size

	# Control para la vista previa:
	var preview = Control.new()
	preview.add_child(preview_texture) # Se asigna al control la textura de la vista previa.
	self.set_drag_preview(preview) # Se asigna el control.
	
	# Se asgina la posición de la vista previa para quedar el cursor centrado:
	preview_texture.position = preview_texture.get_local_mouse_position() - preview_texture.size/2
	# Se retorna la textura, las coordenadas y el nombre del ingrediente:
	return [self.texture_on_pizza, self.ingredient_name]


func get_dropped_data(data: Variant) -> void:
	print_debug(data)



func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		# Cuando no se suelta en un lugar válido, se reestablece la textura predeterminada del robot:
		if !get_viewport().gui_is_drag_successful():
			Sfx.play_sound(Sfx.Sounds.INGREDIENT_RELEASE)
