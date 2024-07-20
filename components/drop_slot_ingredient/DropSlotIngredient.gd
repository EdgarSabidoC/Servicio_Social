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
@onready var texture_rect: TextureRect = $TextureRect

# Bandera que indica si se ha colocado de manera correcta el ingrediente:
@onready var correct: bool = false

@onready var is_hover: bool

## Dropped signal is emitted when data is dropped inside the slot.
signal data_dropped()


func _ready() -> void:
	self.pivot_offset = self.custom_minimum_size/2


func _input(_event: InputEvent) -> void:
	# Si se da click derecho sobre el espacio o textura se rota 45°:
	if self.enable_drop and self.is_hover:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
			self.rotation_degrees += 45
		elif Input.is_action_just_pressed("ui_right"):
			self.rotation_degrees += 45
		elif Input.is_action_just_pressed("ui_left"):
			self.rotation_degrees -= 45
		elif Input.is_action_just_pressed("ui_up"):
			self.rotation_degrees += 90
		elif Input.is_action_just_pressed("ui_down"):
			self.rotation_degrees -= 90


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
	print_debug("Entró con %s"%self.get_ingredient_name())
	match self.ingredient_name:
		"Hongo":
			self.texture = load("res://assets/graphical_assets/environments/pizzas/mushroom.tga")
		"Pepperoni":
			self.texture = load("res://assets/graphical_assets/environments/pizzas/pepperoni.tga")
		"Salami":
			self.texture = load("res://assets/graphical_assets/environments/pizzas/salami.tga")
		"Cebolla":
			self.texture = load("res://assets/graphical_assets/environments/pizzas/onion.tga")
		"Pimiento verde":
			self.texture = load("res://assets/graphical_assets/environments/pizzas/green_pepper.tga")
		"Jamón":
			self.texture = load("res://assets/graphical_assets/environments/pizzas/ham.tga")
		"Pescado":
			self.texture = load("res://assets/graphical_assets/environments/pizzas/fish.tga")


func is_correct() -> bool:
	return self.correct


# Limpia los datos:
func clear_data() -> void:
	if self.texture:
		self.texture = null
	if self.ingredient_name != self.Ingredients.NULL:
		self.ingredient_name = self.Ingredients.NULL
	if self.coordinates:
		self.coordinates = Vector2i(0,0)
	if self.correct:
		self.correct = false
	if !self.texture_rect.is_visible_in_tree():
		self.texture_rect.show()


# Se valida que se pueda soltar una Texture2D:
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if !self.enable_drop:
		# Si no está activo el soltar:
		return false
	return data is Array


# La texture se convierte en la textura que se le suelta:
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	self.texture_rect.hide()
	self.texture = data[0]
	self.coordinates = data[1]
	self.ingredient_name = data[2]
	self.data_dropped.emit() # Se lanza la señal de que se soltaron los datos.


func _on_mouse_entered() -> void:
	self.is_hover = true


func _on_mouse_exited() -> void:
	self.is_hover = false


func _on_minimum_size_changed() -> void:
	self.pivot_offset = self.custom_minimum_size/2
