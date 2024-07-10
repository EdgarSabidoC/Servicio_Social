extends AnimatedTextureRect

##  Allows to drop a Texture2D. Extends AnimatedTextureRect.


## (x,y) coordinates for the element.
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


# Genera de manera aleatoria un ingrediente:
func generate_rand_ingredient() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var i = rng.randi_range(0, 7)
	self.ingredient_name = Ingredients.values()[i]


# Limpia los datos:
func clear_data() -> void:
	if self.texture:
		self.texture = null
	if self.ingredient_name != self.Ingredients.NULL:
		self.ingredient_name = self.Ingredients.NULL
	if self.coordinates:
		self.coordinates = Vector2i(0,0)


# Se valida que se pueda soltar una Texture2D:
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if !self.enable_drop:
		# Si no está activo el soltar:
		return false
	return data is Array


# La texture se convierte en la textura que se le suelta:
func _drop_data(_at_position: Vector2, data: Variant) -> void:
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
