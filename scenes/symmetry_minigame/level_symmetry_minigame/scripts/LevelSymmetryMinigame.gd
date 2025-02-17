extends Node2D

@onready var clock: Clock = $CanvasLayer/Clock
@onready var pause: Control = $CanvasLayer/Pause
@onready var score_label: Label = $CanvasLayer/ScorePanel/ScoreLabel
@onready var pause_btn: Button = $CanvasLayer/PauseBtn
@onready var ingredients_container: VBoxContainer = $CanvasLayer/IngredientsContainer
@onready var current_pitch: float = 1.0
@onready var score_screen: Control = $CanvasLayer/ScoreScreen
@onready var score_panel: Panel = $CanvasLayer/ScorePanel
@onready var score_flash_label: Label = $CanvasLayer/ScoreFlashLabel
@onready var score_label_player: AnimationPlayer = $CanvasLayer/ScoreFlashLabel/AnimationPlayer


# Límites del rango de rebanadas que desaparecerán por dificultad:
## Easy slices lower limit to hide.
@export var easy_slices_lower_limit: int
## Easy slices upper limit to hide.
@export var easy_slices_upper_limit: int
## Medium slices lower limit to hide.
@export var medium_slices_lower_limit: int
## Medium slices upper limit to hide.
@export var medium_slices_upper_limit: int
## Hard slices lower limit to hide.
@export var hard_slices_lower_limit: int
## Hard slices upper limit to hide.
@export var hard_slices_upper_limit: int

# Límites del rango de rebanadas que desaparecerán:
@onready var slices_lower_limit: int
@onready var slices_upper_limit: int

# Límites del rango de ingredientes que desaparecerán por dificultad:
## Easy ingredients lower limit to hide.
@export var easy_ingredients_lower_limit: int
## Easy ingredients upper limit to hide.
@export var easy_ingredients_upper_limit: int
## Medium ingredients lower limit to hide.
@export var medium_ingredients_lower_limit: int
## Medium ingredients upper limit to hide.
@export var medium_ingredients_upper_limit: int
## Hard ingredients lower limit to hide.
@export var hard_ingredients_lower_limit: int
## Hard ingredients upper limit to hide.
@export var hard_ingredients_upper_limit: int

# Límites del rango de ingredientes que desaparecerán en las rebanadas visibles:
@onready var ingredients_lower_limit: int
@onready var ingredients_upper_limit: int

# Tiempos del reloj por dificultad:
## Time for clock on easy difficulty.
@export var time_easy: float = 180
## Time for clock on medium difficulty.
@export var time_medium: float = 120
## Time for clock on hard difficulty.
@export var time_hard: float = 90

## Default score.
@onready var default_score: int = 10000

# Lista que contiene las claves de las rebanadas ocultas:
@onready var hidden_slices: Array = []

# Lista de ingredientes (lado izquierdo):
@onready var ingredient_list: Array = [\
	[%S1L1, %S1L2, %S1L3, %S1L4], \
	[%S2L1, %S2L2, %S2L3, %S2L4], \
	[%S3L1, %S3L2, %S3L3, %S3L4], \
	[%S4L1, %S4L2, %S4L3, %S4L4], \
]

# Lista de ranuras (lado derecho):
@onready var drop_slot_list: Array = [\
	[%S1R1, %S1R2, %S1R3, %S1R4], \
	[%S2R1, %S2R2, %S2R3, %S2R4], \
	[%S3R1, %S3R2, %S3R3, %S3R4], \
	[%S4R1, %S4R2, %S4R3, %S4R4], \
]

# Lista de rebanadas izquierdas:
@onready var left_slice_list: Dictionary = {
	"s1": [%S1L, ingredient_list[0]], \
	"s2": [%S2L, ingredient_list[1]], \
	"s3": [%S3L, ingredient_list[2]], \
	"s4": [%S4L, ingredient_list[3]], \
}

# Lista de rebanadas derechas:
@onready var right_slice_list: Dictionary = {
	"s1": [%S1R, drop_slot_list[0]], \
	"s2": [%S2R, drop_slot_list[1]], \
	"s3": [%S3R, drop_slot_list[2]], \
	"s4": [%S4R, drop_slot_list[3]], \
}


func _enter_tree() -> void:
	# Se configura la música:
	self.set_music()
	# Se hace visible el mouse
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _ready() -> void:
	# Se elige la cantidad de rebanadas por dificultad:
	self.set_slices()
	# Se configura el juego:
	self.set_game()
	# Se conectan las señales:
	self.connect_signals()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if !self.pause.is_active():
			self.clock.stop()
			self.pause.show_menu()


# Automatiza la conexión de las señales con la función check_ingredient:
func connect_signals() -> void:
	for i in range(4):
		for j in range(len(drop_slot_list[i])):
			var left_ingredient = ingredient_list[i][j]
			var right_slot = drop_slot_list[i][j]
			right_slot.data_dropped.connect(func() -> void:
				_on_data_dropped(left_ingredient, right_slot)
			)
			right_slot.rotated.connect(func() -> void:
				_on_data_dropped(left_ingredient, right_slot)
			)


func _on_data_dropped(left_ingredient: Variant, right_slot: Variant) -> void:
	self.check_ingredient(left_ingredient, right_slot)
	self.all_slots_correct()


# Verifica que todas las ranuras sean correctas:
func all_slots_correct() -> void:
	for list in drop_slot_list:
		for slot in list:
			if slot.is_visible_in_tree() and !slot.is_correct():
				return
	if PlayerSession.is_practice_mode():
		self.print_message()
	self._next_round()


# Muestra todas las rebanadas y los ingredientes de ambos lados
func show_all_slices_and_ingredients() -> void:
	# Mostrar todas las rebanadas izquierdas
	for key in self.left_slice_list.keys():
		var left_slice = self.left_slice_list[key][0]
		var left_ingredients = self.left_slice_list[key][1]
		
		# Mostrar la rebanada y todos sus ingredientes
		left_slice.show()
		for ingredient in left_ingredients:
			ingredient.show()
	
	# Mostrar todas las rebanadas derechas
	for key in self.right_slice_list.keys():
		var right_slice = self.right_slice_list[key][0]
		var right_ingredients = self.right_slice_list[key][1]
		
		# Mostrar la rebanada y todos sus ingredientes
		right_slice.show()
		for ingredient in right_ingredients:
			ingredient.show()


# Genera la siguiente pizza:
func _next_round() -> void:
	self._clear_all_data()
	if not PlayerSession.is_practice_mode():
		self.set_score()
		# Se imprime el puntaje:
		self.print_score()
	else:
		# Se imprime el mensaje aleatorio:
		self.print_message()
	
	# Mostrar todas las rebanadas e ingredientes antes de configurar la nueva pizza
	self.show_all_slices_and_ingredients()
	
	self.set_pizza()


# Configura la música de fondo:
func set_music() -> void:
	# Se cambia la música:
	var current_position: float = 0
	var volume: float = 0
	BackgroundMusic.start_minigame_song(volume, current_position)


# Configura el tiempo del reloj:
func set_clock() -> void:
	self.clock.reset_color()
	match PlayerSession.difficulty:
		"easy":
			self.clock.time = self.time_easy
		"medium":
			self.clock.time = self.time_medium
		"hard":
			self.clock.time = self.time_hard
	if PlayerSession.is_practice_mode():
		self.clock.stop()


# Configura la cantidad de rebanadas que van a desaparecer:
func set_slices() -> void:
	match PlayerSession.difficulty:
		"easy":
			self.slices_lower_limit = self.easy_slices_lower_limit
			self.slices_upper_limit = self.easy_slices_upper_limit
		"medium":
			self.slices_lower_limit = self.medium_slices_lower_limit
			self.slices_upper_limit = self.medium_slices_upper_limit
		"hard":
			self.slices_lower_limit = self.hard_slices_lower_limit
			self.slices_upper_limit = self.hard_slices_upper_limit


# Selecciona un número de ingredientes dentro de un rango según dificultad (aleatoriamente):
func set_hidden_ingredients_number() -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	match PlayerSession.difficulty:
		"easy":
			self.ingredients_lower_limit = self.easy_ingredients_lower_limit
			self.ingredients_upper_limit = self.easy_ingredients_upper_limit
		"medium":
			self.ingredients_lower_limit = self.medium_ingredients_lower_limit
			self.ingredients_upper_limit = self.medium_ingredients_upper_limit
		"hard":
			self.ingredients_lower_limit = self.hard_ingredients_lower_limit
			self.ingredients_upper_limit = self.hard_ingredients_upper_limit
	return rng.randi_range(self.ingredients_lower_limit, self.ingredients_upper_limit)


# Oculta al azar ingredientes de las rebanadas visibles:
func hide_random_ingredients() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	# Lista de claves de las rebanadas izquierdas:
	var slice_keys: Array = self.left_slice_list.keys()
	
	for key in slice_keys:
		if key in self.hidden_slices:
			# Si la rebanada está oculta, se brinca a la siguiente clave:
			continue
		
		# Se obtienen las listas de ingredientes izquierdos y derechos:
		var left_ingredients = self.left_slice_list[key][1]
		var right_ingredients = self.right_slice_list[key][1]
		
		# Se asegura de que no se oculten más ingredientes de los disponibles y que el máximo no exceda 3:
		var number_of_ingredients = self.set_hidden_ingredients_number()
		var ingredients_to_hide: int = min(number_of_ingredients, min(left_ingredients.size(), 3))
		
		# Se seleccionan y ocultan los ingredientes al azar manteniendo la simetría:
		var indices_to_hide: Array = []
		while indices_to_hide.size() < ingredients_to_hide:
			var ingredient_index: int = rng.randi_range(0, left_ingredients.size() - 1)
			if ingredient_index not in indices_to_hide:
				indices_to_hide.append(ingredient_index)
		
		for index in indices_to_hide:
			# Se ocultan el ingrediente izquierdo y su contraparte derecha:
			left_ingredients[index].hide()
			right_ingredients[index].hide()


# Configura las rebanadas que se mostrarán:
func set_pizza() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	# Lista de claves de las rebanadas izquierdas:
	var slice_keys: Array = self.left_slice_list.keys()
	# Número de rebanadas a ocultar basado en los límites de dificultad:
	var number_of_slices: int = rng.randi_range(self.slices_lower_limit, self.slices_upper_limit)
	var slices_to_hide: int = min(number_of_slices, slice_keys.size())
	
	# Lista de rebanadas a ocultar
	var slices_to_hide_list: Array = []
	
	while slices_to_hide_list.size() < slices_to_hide:
		var index: int = rng.randi_range(0, slice_keys.size() - 1)
		var key: String = slice_keys[index]
		if key not in slices_to_hide_list:
			slices_to_hide_list.append(key)
	
	for key in slices_to_hide_list:
		# Se oculta la rebanada:
		left_slice_list[key][0].hide()
		right_slice_list[key][0].hide()
		
		# Se ocultan los ingredientes de la respectiva rebanada:
		for ingredient in left_slice_list[key][1]:
			ingredient.hide()

		for ingredient in right_slice_list[key][1]:
			ingredient.hide()
		
		self.hidden_slices.append(key)
		slice_keys.erase(key)
	
	# Se ocultan al azar algunos ingredientes de las rebanadas visibles:
	self.hide_random_ingredients()
	
	# Se configuran los ingredientes:
	self.set_ingredients()


# Imprime el puntaje:
func print_score() -> void:
	Sfx.play_sound(Sfx.Sounds.SCORE)
	self.score_flash_label.text = "+%s" % self.default_score
	self.score_label_player.play("fade_out")
	self.score_label.print_score()


# Imprime un mensaje aleatorio:
func print_message():
	var label_text: int = RandomNumberGenerator.new().randi_range(0, 100)
	if label_text >= 90:
		self.score_flash_label.text = "¡Excelente!"
	elif label_text >= 80:
		self.score_flash_label.text = "¡Muy bien!"
	elif label_text >= 70:
		self.score_flash_label.text = "¡Bien hecho!"
	elif label_text >= 60:
		self.score_flash_label.text = "¡Eso es!"
	elif label_text >= 50:
		self.score_flash_label.text = "¡Sigue así!"
	elif label_text >= 40:
		self.score_flash_label.text = "¡Gran trabajo!"
	elif label_text >= 30:
		self.score_flash_label.text = "¡Lo lograste!"
	elif label_text >= 20:
		self.score_flash_label.text = "¡Perfecto!"
	elif label_text >= 10:
		self.score_flash_label.text = "¡Increíble!"
	else:
		self.score_flash_label.text = "¡Buen esfuerzo!"
	
	Sfx.play_sound(Sfx.Sounds.SCORE)
	self.score_flash_label.set("theme_override_colors/font_color", Color.BLUE)
	self.score_label_player.play("fade_out")


# Configura los ingredientes:
func set_ingredients():
	for list in self.ingredient_list:
		for ingredient in list:
			# Se generan los ingredientes aleatorios:
			ingredient.generate_rand_ingredient()
			# Se rota aleatoriamente en intervalos de 45° dentro del rango 0 a 315°:
			var random_rotation = randi_range(0, 7) * 45
			ingredient.rotation_degrees = self.clamp_rotation(random_rotation)

 
# Función para limitar el ángulo a 0-360 grados
func clamp_rotation(angle: float) -> float:
	if angle < 0:
		return fmod(360 + angle, 360)
	elif angle >= 360:
		return fmod(angle, 360)
	return angle


# Configura la partida:
func set_game() -> void:
	# Se inicializa el puntaje en 0:
	PlayerSession.score = 0
	
	# Se reinicia el puntaje por predeterminado:
	self.default_score = 10000
	
	# Se configuran el tiempo y la pizza:
	self.set_clock()
	
	# Mostrar todas las rebanadas e ingredientes antes de configurar la nueva pizza
	self.show_all_slices_and_ingredients()
	self.set_pizza()
	
	# Si es el modo práctica no se muestra ni el puntaje ni el reloj:
	if !PlayerSession.is_practice_mode():
		self.score_panel.show()
		self.clock.show()
		# Se imprime el puntaje:
		self.score_label.print_score()
		self.score_flash_label.set("theme_override_colors/font_color", Color.DARK_GREEN)
		
		# Contiúa la animación del reloj:
		self.clock.continue_clock()
	else:
		self.score_flash_label.set_position(Vector2(30, 32))

# Reduce el puntaje predeterminado:
func reduce_default_score() -> void:
	self.default_score -= 1250


# Otorga un puntaje basándose en el tiempo:
func set_score() -> void:
	PlayerSession.score += self.default_score


# Compara dos ángulos exactos teniendo en cuenta que el ángulo del lado derecho está siempre volteado horizontalmente
func compare_angles(left_angle: float, right_angle: float) -> bool:
	var comparison: bool = false
	match int(left_angle):
		0:
			if right_angle == int(0):
				comparison = true
		45:
			if right_angle == int(315):
				comparison = true
		90:
			if right_angle == int(270):
				comparison = true
		135:
			if right_angle == int(225):
				comparison = true
		180:
			if right_angle == int(180):
				comparison = true
		225:
			if right_angle == int(135):
				comparison = true
		270:
			if right_angle == int(90):
				comparison = true
		315:
			if right_angle == int(45):
				comparison = true
	return comparison


# Compara el ingrediente del lado izquierdo con el que se encuentra en la ranura derecha correspondiente:
func check_ingredient(left_ingredient: AnimatedTextureRect, right_ingredient: AnimatedTextureRect) -> bool:
	right_ingredient.set_correct(
		compare_angles(left_ingredient.rotation_degrees, right_ingredient.rotation_degrees) and
		left_ingredient.ingredient_name == right_ingredient.ingredient_name and
		left_ingredient.coordinates == right_ingredient.coordinates
		# Si es correcto se convierte en true. En otro caso es false.
	)
	return right_ingredient.correct


func _on_pause_finished() -> void:
	if not PlayerSession.is_practice_mode():
		self.clock.continue_clock()
	self.pause.hide()


func _clear_all_data():
	for list in self.drop_slot_list:
		for slot in list:
			slot.clear_data()
	self.hidden_slices = []


func _on_reset_pressed() -> void:
	for list in self.drop_slot_list:
		for slot in list:
			if slot.texture:
				slot.clear_data()


func _on_pause_btn_pressed() -> void:
	if !self.pause.is_active():
		if !Mouse.mouse_mode_activated:
			self.pause.continue_btn.grab_focus()
		else:
			self.pause_btn.release_focus()
		self.clock.stop()
		self.pause.show_menu()


# Cuando se llegue a un pivote en cuenta atrás se aumenta la velocidad de la música:
func _on_clock_pivot_changed() -> void:
	# Se aumenta el pitch_scale de la música por cada minuto de juego:
	self.current_pitch += 0.1
	BackgroundMusic.change_pitch(self.current_pitch)
	
	# Se reduce el puntaje por defecto:
	self.reduce_default_score()
	
	# Se cambian los colores del score_flash_label de acuerdo a default_score:
	if self.default_score == 10000:
		self.score_flash_label.set("theme_override_colors/font_color", Color.DARK_GREEN)
	elif self.default_score == 8750:
		self.score_flash_label.set("theme_override_colors/font_color", Color.BLUE)
	elif self.default_score == 7500:
		self.score_flash_label.set("theme_override_colors/font_color", Color.ORANGE)
	elif self.default_score <= 6250:
		self.score_flash_label.set("theme_override_colors/font_color", Color.RED)


func _on_clock_countdown_finished() -> void:
	# Se reinicia el pitch de la canción:
	BackgroundMusic.change_pitch(1.0)
	
	# Se muestra la pantalla de puntajes:
	self.score_screen.show()
	self.score_screen.print_score()


func _on_score_screen_restart_game() -> void:
	# Se configura el juego/partida:
	self._clear_all_data()
	self.set_game()


func _on_tree_exiting() -> void:
	# A salir se verifica el modo de entrada:
	if not Mouse.mouse_mode_activated:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
