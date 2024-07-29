extends AnimatedTextureRect

## Allows to drop a coordinate (X,Y) [Vector2i], 
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

## If true, the background texture is hidden (recommended for drag texture).
@export var hide_background: bool = true

## Background texture.
@export var background: Texture2D

## Minimun size for background:
@export var background_custom_minimum_size: Vector2

## Easy difficulty timeout to hide the pizza on the table.
@export var easy_timeout: float
## Medium difficulty timeout to hide the pizza on the table.
@export var medium_timeout: float
## Hard difficulty timeout to hide the pizza on the table.
@export var hard_timeout: float

## (X,Y) coordinates.
@export var coordinates: Vector2i = Vector2i(0,0)

@onready var pizza: TextureRect = $Pizza


## Dropped signal is emitted when data (Vector2i of coordinates) is dropped.
signal data_dropped()
## Signal is emitted when timer starts.
signal timer_started()
## Signal is emitted when timer ends.
signal timer_ended()


func _ready() -> void:
	self.set_background()
	self.pivot_offset = self.custom_minimum_size/2
	if self.animation_as == self.AnimationOptions.BOTH or self.animation_as == self.AnimationOptions.TEXTURE:
		# Si es modo Texture o Both se reproduce la animación:
		self.play()
	else:
		# Si el modo preview es para la animación:
		self.auto_play = false
		self.stop()
	# Se verifica que las coordenadas estén dentro de los límites:
	self.check_coordinates_limits()


# Se valida que se pueda soltar un Vector2i [Coordenada(X,Y)]:
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Vector2i and !self.pizza.is_visible_in_tree()


# Se obtiene una coordenada(X,Y) [Vector2i]:
func _drop_data(_at_position: Vector2, _data: Variant) -> void:
	self.pizza.show()
	self.data_dropped.emit() # Se lanza la señal de que se soltaron los datos.
	self.start_timer()


# Inicia un timer para una mesa:
func start_timer() -> void:
	self.timer_started.emit()
	var time: float
	match PlayerSession.difficulty:
		"easy":
			time = self.easy_timeout
		"medium":
			time = self.medium_timeout
		"hard":
			time = self.hard_timeout
	await get_tree().create_timer(time).timeout
	self.timer_ended.emit()
	self.restart()


# Oculta de nuevo la pizza:
func restart() -> void:
	if self.pizza.is_visible_in_tree():
		self.pizza.hide()


# Configura el fondo del nodo:
func set_background(background_texture: Texture2D = self.background) -> void:
	if !self.hide_background:
		self.background_texture_rect.show()
		if background_texture:
			self.background_texture_rect.texture = background_texture
			self.size = background_custom_minimum_size


# Asigna un par de coordenadas:
func set_coordinates(_coordinates: Vector2i) -> void:
	self.coordinates = Vector2i(_coordinates.x, _coordinates.y)


# Obtiene las coordenadas:
func get_coordinates() -> Vector2i:
	return self.coordinates


# Compara las coordenadas que se le pasan con las del nodo:
func compare_coordinates(coordinates_vector: Vector2i) -> bool:
	return self.get_coordinates() == coordinates_vector


# Verifica que las coordenadas estén dentro de los límites.
# De manera predeterminada asigna los límites como coordenadas si los límites
# se salen.
func check_coordinates_limits() -> void:
	# Límites superiores:
	if self.coordinates.x > self.x_upper_limit:
		self.coordinates.x = self.x_upper_limit
	if self.coordinates.y > self.y_upper_limit:
		self.coordinates.y = self.y_upper_limit
	# Límites inferiores:
	if self.coordinates.x < self.x_lower_limit:
		self.coordinates.x = self.x_lower_limit
	if self.coordinates.y < self.y_lower_limit:
		self.coordinates.y = self.y_lower_limit
