extends Node2D

@onready var clock: Clock = $CanvasLayer/Clock
@onready var pause: Control = $CanvasLayer/Pause
@onready var drop_slot_ingredient: TextureRect = $CanvasLayer/DropSlotIngredient
@onready var drop_slot_list: Array[AnimatedTextureRect] = [drop_slot_ingredient]
@onready var score_label: Label = $CanvasLayer/ScorePanel/ScoreLabel


func _ready() -> void:
	# Se inicializa el puntaje en 0:
	PlayerSession.score = 0
	
	# Se imprime el puntaje:
	self.score_label.print_score()
	
	# Se configuran los tiempos del reloj:
	match PlayerSession.difficulty:
		"easy":
			self.clock.time = 120
		"medium":
			self.clock.time = 90
		"hard":
			self.clock.time = 60


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if !self.pause.is_active():
			self.clock.stop()
			self.pause.show()


func _on_pause_finished() -> void:
	if !Mouse.mouse_mode_activated:
		pass
	self.clock.continue_clock()
	self.pause.hide()


# Cuando se llegue a un minuto nuevo se aumenta la velocidad de la música:
func _on_clock_new_minute_reached() -> void:
	# Se aumenta el pitch_scale de la música por cada minuto de juego:
	self.current_pitch += 0.1
	BackgroundMusic.change_pitch(self.current_pitch)


func _on_reset_pressed() -> void:
	for slot in self.drop_slot_list:
		if slot.texture:
			slot.clear_data()


func _on_drop_slot_ingredient_data_dropped() -> void:
	print_debug(drop_slot_ingredient.get_data_formatted())
