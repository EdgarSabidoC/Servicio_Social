extends AnimatedTextureRect

## Allows to drag and drop an array with a Texture2D and a coordinate (X,Y), 
## preview animation can be set on Sprites from AnimatedTextureRect.
## Extends AnimatedTextureRect.
## AnimatedTextureRect animation has higher precedence than Texture from TextureRect.
## Auto play and Playing are disabled by default on Preview mode.

## Lower limit for X coordinate.
@export var x_lower_limit: int
## Upper limit for X coordinate.
@export var x_upper_limit: int
## Lower limit for Y coordinate.
@export var y_lower_limit: int
## Upper limit for Y coordinate.
@export var y_upper_limit: int

enum AnimationOptions {## Options to use the Sprites animation as preview, texture or both
						PREVIEW = 0, ## Preview mode active
						TEXTURE = 1, ## Texture mode active
						BOTH = 2, ## Preview and Texture modes active
						}
## Options for using Sprites from SpriteFrames (AnimatedTextureRect) as preview or texture
@export var animation_as: AnimationOptions = self.AnimationOptions.PREVIEW

## Size of preview animation or texture
@export var preview_size: Vector2 = Vector2(50, 50)

# Coordenadas (X,Y):
@onready var _coordinates: Vector2i
@onready var animation_player: AnimationPlayer = $AnimationPlayer


## Dropped signal is emitted when data is dropped inside another DragTexture.
signal data_dropped()


func _ready() -> void:
	self.pivot_offset = self.custom_minimum_size/2
	if self.animation_as == self.AnimationOptions.BOTH \
	or self.animation_as == self.AnimationOptions.TEXTURE:
		# Si es modo Texture o Both se reproduce la animación:
		self.play()
	else:
		# Si el modo preview es para la animación:
		self.auto_play = false
		self.stop()
	# Se valida que las coordenadas estén dentro de los límites:
	self.validate_coordinates()
	self.animation_player.play("enter")


func _get_drag_data(_at_position: Vector2) -> Variant:
	# Textura de la vista previa:
	var preview_texture =  AnimatedTextureRect.new()
	
	# Se oculta el mouse:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# Se valida si hay sprites y si es modo Preview o Both:
	if self.sprites and (self.animation_as == AnimationOptions.PREVIEW or \
						self.animation_as == AnimationOptions.BOTH):
		# Se asigna la animación actual a la del preview:
		preview_texture.current_animation = self.current_animation
		preview_texture.sprites = self.sprites # Se asignan los sprites al preview
		preview_texture.play("drag") # Se reproduce la animación
	else:
		# Si es modo texture o no hay sprites:
		preview_texture.texture = self.texture # Se asigna la textura de la vista previa.
	
	# Se cambia el tamaño de la textura del preview:
	preview_texture.expand_mode = EXPAND_IGNORE_SIZE
	preview_texture.size = self.preview_size

	# Control para la vista previa:
	var preview = Control.new()
	preview.add_child(preview_texture) # Se asigna al control la textura de la vista previa.
	self.set_drag_preview(preview) # Se asigna el control.
	
	# Se asgina la posición de la vista previa para quedar el cursor centrado:
	preview_texture.position = preview_texture.get_local_mouse_position() - preview_texture.size/2
	if self.animation_as == self.AnimationOptions.BOTH or \
	self.animation_as == self.AnimationOptions.PREVIEW:
		self.play("restart")
	else:
		self.texture = null

	# Se retorna la textura y las coordenadas:
	return self


# Asigna un par de coordenadas:
func set_coordinates(coordinates: Vector2i) -> void:
	self._coordinates = Vector2i(coordinates.x, coordinates.y)


# Obtiene las coordenadas:
func get_coordinates() -> Vector2i:
	return self._coordinates


# Valida que las coordenadas estén dentro de los límites.
# De manera predeterminada asigna los límites como coordenadas si los límites
# se salen.
func validate_coordinates() -> void:
	# Límites superiores:
	if self._coordinates.x > self.x_upper_limit:
		self._coordinates.x = self.x_upper_limit
	if self._coordinates.y > self.y_upper_limit:
		self._coordinates.y = self.y_upper_limit
	# Límites inferiores:
	if self._coordinates.x < self.x_lower_limit:
		self._coordinates.x = self.x_lower_limit
	if self._coordinates.y < self.y_lower_limit:
		self._coordinates.y = self.y_lower_limit


# Genera un par de coordenadas aleatorias:
func set_rand_coordinates() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()	
	var x: int = rng.randi_range(self.x_lower_limit, self.x_upper_limit)
	var y: int = rng.randi_range(self.y_lower_limit, self.y_upper_limit)
	self.set_coordinates(Vector2i(x,y))


# Reinicia la animación del robot y le devuelve su textura:
func restart() -> void:
	# Aquí se debe reproducir la animación para hacer que salga de la puerta el robot.
	# AÑADIR CÓDIGO.
	self.play("enter")
	self.animation_player.play("enter")


func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		# Cuando no se suelta en un lugar válido, se reestablece la textura predeterminada del robot:
		if !get_viewport().gui_is_drag_successful():
			self.play("idle")
		else:
			# Si se soltó correctamente, entonces se reinicia la animación de entrada:
			self.restart()
