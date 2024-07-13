extends Node2D

@onready var clock: Clock = $CanvasLayer/Clock
@onready var pause: Control = $CanvasLayer/Pause
@onready var score_label: Label = $CanvasLayer/ScorePanel/ScoreLabel
@onready var pause_btn: Button = $CanvasLayer/PauseBtn
@onready var ingredients_container: VBoxContainer = $CanvasLayer/IngredientsContainer
@onready var current_pitch: float = 1.0
@onready var score_screen: Control = $CanvasLayer/ScoreScreen

# Límites del rango de rebanadas que desaparecerán:
@onready var upper_limit: int
@onready var lower_limit: int

# Tiempos del reloj por dificultad:
@export var time_easy: float = 180
@export var time_medium: float = 120
@export var time_hard: float = 90

# Lista de ingredientes (lado izquierdo):
@onready var ingredient_list: Array = [\
	[%S1L1, %S1L2, %S1L3, %S1L4], \
	[%S2L1, %S2L2, %S2L3], \
	[%S3L1, %S3L2, %S3L3, %S3L4], \
	[%S4L1, %S4L2, %S4L3, %S4L4], \
]

# Lista de ranuras (lado derecho):
@onready var drop_slot_list: Array = [\
	[%S1R1, %S1R2, %S1R3, %S1R4], \
	[%S2R1, %S2R2, %S2R3], \
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


func _ready() -> void:
	# Se elige la cantidad de rebanadas por dificultad:
	self.set_slices()
	# Se configura el juego:
	self.set_game()
	
	# Se conectan las señales:
	# Rebanada 1:
	%S1R1.data_dropped.connect(check_ingredient.bind([%S1L1, %S1R1]))
	%S1R2.data_dropped.connect(check_ingredient.bind([%S1L2, %S1R2]))
	%S1R3.data_dropped.connect(check_ingredient.bind([%S1L3, %S1R3]))
	%S1R4.data_dropped.connect(check_ingredient.bind([%S1L4, %S1R4]))
	
	# Rebanada 2:
	%S2R1.data_dropped.connect(check_ingredient.bind([%S2L1, %S2R1]))
	%S2R2.data_dropped.connect(check_ingredient.bind([%S2L2, %S2R2]))
	%S2R3.data_dropped.connect(check_ingredient.bind([%S2L3, %S2R3]))
	
	# Rebanada 3:
	%S3R1.data_dropped.connect(check_ingredient.bind([%S3L1, %S3R1]))
	%S3R2.data_dropped.connect(check_ingredient.bind([%S3L2, %S3R2]))
	%S3R3.data_dropped.connect(check_ingredient.bind([%S3L3, %S3R3]))
	%S3R4.data_dropped.connect(check_ingredient.bind([%S3L4, %S3R4]))
	
	# Rebanada 4:
	%S4R1.data_dropped.connect(check_ingredient.bind([%S4L1, %S4R1]))
	%S4R2.data_dropped.connect(check_ingredient.bind([%S4L2, %S4R2]))
	%S4R3.data_dropped.connect(check_ingredient.bind([%S4L3, %S4R3]))
	%S4R4.data_dropped.connect(check_ingredient.bind([%S4L4, %S4R4]))


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if !self.pause.is_active():
			self.clock.stop()
			self.pause.show()
	
	# Se verifica que todas las ranuras estén correctas:
	if self.all_slots_correct():
		PlayerSession.score += 10000
		self.set_pizza()


# Verifica si todos las ranuras sean correctas:
func all_slots_correct() -> bool:
	for list in drop_slot_list:
		for slot in list:
			if !slot.is_correct():
				return false
	return true


# Configura la música de fondo:
func set_music() -> void:
	# Se cambia la música:
	var current_position: float = 0
	var volume: float = 0
	BackgroundMusic.start_minigame_song(volume, current_position)


# Configura el tiempo del reloj:
func set_clock() -> void:
	match PlayerSession.difficulty:
		"easy":
			self.clock.time = self.time_easy
		"medium":
			self.clock.time = self.time_medium
		"hard":
			self.clock.time = self.time_hard


# Configura la cantidad de rebanadas que van a desaparecer:
func set_slices() -> void:
	match PlayerSession.difficulty:
		"easy":
			self.lower_limit = 0
			self.upper_limit = 1
		"medium":
			self.lower_limit = 1
			self.upper_limit = 2
		"hard":
			self.lower_limit = 1
			self.upper_limit = 3


# Configura las rebanadas que se mostrarán:
func set_pizza() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	var slice_keys: Array = left_slice_list.keys()
	var slices_to_hide: Variant = min(rng.randi_range(self.lower_limit, self.upper_limit), slice_keys.size())

	for _i in range(slices_to_hide):
		var index: int = rng.randi_range(0, slice_keys.size() - 1)
		var key: String = slice_keys[index]

		left_slice_list[key][0].hide()
		right_slice_list[key][0].hide()

		for ingredient in left_slice_list[key][1]:
			ingredient.hide()

		for ingredient in right_slice_list[key][1]:
			ingredient.hide()

		slice_keys.remove_at(index)
	
	# Se configuran los ingredientes:
	self.set_ingredients()


# Configura los ingredientes:
func set_ingredients():
	# Se generan los ingredientes aleatorios:
	for list in self.ingredient_list:
		for ingredient in list:
			ingredient.generate_rand_ingredient()
			# Se rota aleatoriamente en intervalos de 45°:
			ingredient.rotation_degrees = randi_range(0, 7) * 45


# Configura la partida:
func set_game() -> void:	
	# Se inicializa el puntaje en 0:
	PlayerSession.score = 0
	
	# Se imprime el puntaje:
	self.score_label.print_score()
	
	# Se configuran el tiempo y la pizza:
	self.set_clock()
	self.set_pizza()
	
	# Contiúa el reloj:
	self.clock.continue_clock()


func check_ingredient(left_ingredient: AnimatedTextureRect, right_ingredient: AnimatedTextureRect) -> bool:
	if left_ingredient.rotation_degrees == right_ingredient.rotation_degrees and \
	left_ingredient.ingredient_name == right_ingredient.ingredient_name and \
	left_ingredient.coordinates == right_ingredient.coordinates:
		right_ingredient.correct = true # Se indica que se ha colocado de manera correcta el ingrediente.
	else:
		right_ingredient.correct = false # Se indica que es incorrecto el ingrediente.
	return right_ingredient.is_correct()


func _on_pause_finished() -> void:
	if !Mouse.mouse_mode_activated:
		pass
	self.clock.continue_clock()
	self.pause.hide()


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
		self.pause.show()


# Cuando se llegue a un pivote en cuenta atrás se aumenta la velocidad de la música:
func _on_clock_pivot_changed() -> void:
	# Se aumenta el pitch_scale de la música por cada minuto de juego:
	self.current_pitch += 0.1
	BackgroundMusic.change_pitch(self.current_pitch)


func _on_clock_countdown_finished() -> void:
	# Se reinicia el pitch de la canción:
	BackgroundMusic.change_pitch(1.0)
	
	# Se muestra la pantalla de puntajes:
	self.score_screen.show()
	self.score_screen.print_score()


func _on_score_screen_restart_game() -> void:
	# Se configura el juego/partida:
	self.set_game()
