##  Allows to drop a Texture2D. Extends AnimatedTextureRect.
extends AnimatedTextureRect

## (x,y) coordinates for the element. X is for slice index and Y is for ingredient index.
@export var coordinates: Vector2i

## If enabled, a DragIngredient can be dropped inside.
@export var enable_drop: bool = true

enum Ingredients {## Options of possible ingredients to use
					NULL = 0,
					MUSHROOM=1,
					PEPPERONI=2,
					SALAMI=3,
					ONION=4,
					GREEN_PEPPER=5,
					HAM=6,
					FISH=7
				}

@export var ingredient_name: Ingredients

## TextureRect used as background.
@onready var background: TextureRect = $Background

# Bandera que indica si se ha colocado de manera correcta el ingrediente:
@onready var correct: bool = false

@onready var is_hover: bool

## Dropped signal is emitted when data is dropped inside the slot.
signal data_dropped()
signal rotated()

func _ready() -> void:
	self.pivot_offset = self.custom_minimum_size/2


func _input(_event: InputEvent) -> void:
	if self.enable_drop and self.is_hover:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			self.rotation_degrees = clamp_rotation(self.rotation_degrees + 45)
			self.rotated.emit() # Se lanza la señal de que se soltaron los datos.
		elif Input.is_action_just_pressed("ui_right"):
			self.rotation_degrees = clamp_rotation(self.rotation_degrees + 45)
			self.rotated.emit() # Se lanza la señal de que se soltaron los datos.
		elif Input.is_action_just_pressed("ui_left"):
			self.rotation_degrees = clamp_rotation(self.rotation_degrees - 45)
			self.rotated.emit() # Se lanza la señal de que se soltaron los datos.
		elif Input.is_action_just_pressed("ui_up"):
			self.rotation_degrees = clamp_rotation(self.rotation_degrees + 90)
			self.rotated.emit() # Se lanza la señal de que se soltaron los datos.
		elif Input.is_action_just_pressed("ui_down"):
			self.rotation_degrees = clamp_rotation(self.rotation_degrees - 90)
			self.rotated.emit() # Se lanza la señal de que se soltaron los datos.


# Función para limitar el ángulo a 0-360 grados
func clamp_rotation(angle: float) -> float:
	if angle < 0:
		return fmod(360 + angle, 360)
	elif angle >= 360:
		return fmod(angle, 360)
	return angle


func set_correct(c: bool) -> void:
	self.correct = c 


# Retorna el nombre del ingrediente:
func get_ingredient_name(name_of_ingredient: Ingredients = self.ingredient_name) -> String:
	var ingredient: String = ""
	match name_of_ingredient:
		self.Ingredients.MUSHROOM:
			ingredient = "Hongo"
		self.Ingredients.PEPPERONI:
			ingredient = "Pepperoni"
		self.Ingredients.SALAMI:
			ingredient = "Salami"
		self.Ingredients.ONION:
			ingredient = "Cebolla"
		self.Ingredients.GREEN_PEPPER:
			ingredient = "Pimiento verde"
		self.Ingredients.HAM:
			ingredient = "Jamón"
		self.Ingredients.FISH:
			ingredient = "Pescado"
	return ingredient


func get_data_formatted() -> String:
	return "%s, %s" % [self.coordinates, self.get_ingredient_name()]


# Genera de manera aleatoria un ingrediente y carga su textura:
func generate_rand_ingredient() -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var i = rng.randi_range(1, 7)
	self.ingredient_name = Ingredients.values()[i]
	self._load_ingredient_texture()
	return self.ingredient_name


# Carga la textura de un ingrediente (utilizada en generate_rand_ingredient por defecto):
func _load_ingredient_texture() -> void:
	#print_debug("Entró con %s"%self.get_ingredient_name())
	self.background.hide()
	match self.ingredient_name:
		self.Ingredients.MUSHROOM:
			self.texture = load("res://assets/graphical_assets/environments/pizzas/mushroom.tga")
		self.Ingredients.PEPPERONI:
			self.texture = load("res://assets/graphical_assets/environments/pizzas/pepperoni.tga")
		self.Ingredients.SALAMI:
			self.texture = load("res://assets/graphical_assets/environments/pizzas/salami.tga")
		self.Ingredients.ONION:
			self.texture = load("res://assets/graphical_assets/environments/pizzas/onion.tga")
		self.Ingredients.GREEN_PEPPER:
			self.texture = load("res://assets/graphical_assets/environments/pizzas/green_pepper.tga")
		self.Ingredients.HAM:
			self.texture = load("res://assets/graphical_assets/environments/pizzas/ham.tga")
		self.Ingredients.FISH:
			self.texture = load("res://assets/graphical_assets/environments/pizzas/fish.tga")


func is_correct() -> bool:
	return self.correct


# Limpia los datos:
func clear_data() -> void:
	if self.texture:
		self.texture = null
	if self.ingredient_name != self.Ingredients.NULL:
		self.ingredient_name = self.Ingredients.NULL
	if !self.background.is_visible_in_tree():
		self.background.show()
	self.rotation_degrees = 0
	self.correct = false


# Se valida que se pueda soltar una Texture2D:
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if !self.enable_drop:
		# Si no está activo el soltar:
		return false
	return data is Array


# La texture se convierte en la textura que se le suelta:
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	self.background.hide()
	#print_debug("Entró a _drop_data con (%s, %s)" %[data[0], data[1]])
	self.texture = data[0]
	self.ingredient_name = data[1]
	self.data_dropped.emit() # Se lanza la señal de que se soltaron los datos.


func _on_mouse_entered() -> void:
	self.is_hover = true


func _on_mouse_exited() -> void:
	self.is_hover = false


func _on_minimum_size_changed() -> void:
	self.pivot_offset = self.custom_minimum_size/2
