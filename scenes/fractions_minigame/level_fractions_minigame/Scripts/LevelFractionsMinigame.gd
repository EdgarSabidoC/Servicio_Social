extends Node2D

# Variables:
@onready var score_panel: Panel = $CanvasLayer/ScorePanel
@onready var pause: Control = $CanvasLayer/Pause
@onready var character: int
@onready var answer_button_1: AnswerButton = $CanvasLayer/Control/GridContainer/AnswerButton1
@onready var answer_button_2: AnswerButton = $CanvasLayer/Control/GridContainer/AnswerButton2
@onready var answer_button_3: AnswerButton = $CanvasLayer/Control/GridContainer/AnswerButton3
@onready var answer_button_4: AnswerButton = $CanvasLayer/Control/GridContainer/AnswerButton4
@onready var clock: Clock = $CanvasLayer/Clock
@onready var defeated: bool = false
@onready var score_label: Label = $CanvasLayer/ScorePanel/ScoreLabel
@onready var extras_container = $CanvasLayer/Control/ExtrasContainer
@onready var buttons: Array[AnswerButton] = [answer_button_1, answer_button_2, answer_button_3, answer_button_4]
@onready var answers: Array[Dictionary]
@onready var current_pitch = 1.0
@onready var outro_cutscene: PackedScene = load("res://scenes/fractions_minigame/cutscenes/outro_cutscene/OutroCutscene.tscn")
@onready var score_flash_label: Label = $CanvasLayer/ScoreFlashLabel
@onready var score_label_player: AnimationPlayer = $CanvasLayer/ScoreFlashLabel/AnimationPlayer
@onready var icons_container: HBoxContainer = $CanvasLayer/IconsContainer
@onready var alux_icon: TextureRect = $CanvasLayer/IconsContainer/AluxIcon
@onready var toh_icon: TextureRect = $CanvasLayer/IconsContainer/TohIcon
@onready var zotz_icon: TextureRect = $CanvasLayer/IconsContainer/ZotzIcon
@onready var huolpoch_icon: TextureRect = $CanvasLayer/IconsContainer/HuolpochIcon
@onready var keken_icon: TextureRect = $CanvasLayer/IconsContainer/KekenIcon


## Default score.
@onready var default_score: int = 10000
## Bonus multiplier.
@onready var bonus_multiplier: int = 1


func _enter_tree() -> void:
	# Se configura la música:
	self.set_music()
	# Se activa el mouse independientemente del modo de entrada:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	

func _ready() -> void:	
	# Se enfoca el botón 1 si está en modo teclado:
	self.answer_button_1.grab_focus()
	
	# Se configura el juego/partida:
	self.set_game()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if !self.pause.is_active():
			self.clock.stop()
			self.pause.show_menu()


# Muestra los íconos de los personajes derrotados:
func show_icons() -> void:
	for _character in CharactersData.characters:
		if not _character.defeated:
			# Si el personaje no ha sido derrotado se pasa al siguiente:
			continue
		# Se activa el ícono del personaje derrotado:
		match _character.name:
			"Alux":
				self.alux_icon.show()
			"Toh":
				self.toh_icon.show()
			"Zotz":
				self.zotz_icon.show()
			"Huolpoch":
				self.huolpoch_icon.show()
			"Keken":
				self.keken_icon.show()


# Configura el puntaje por defecto con bonus según dificultad:
func set_bonus() -> void:
	
	match PlayerSession.difficulty:
		"medium":
			self.default_score = 12000
		"hard":
			self.default_score = 15000
	
	for _character in CharactersData.characters:
			if _character.defeated:
				self.bonus_multiplier *= _character.bonus_multiplier
	self.default_score *= self.bonus_multiplier


# Configura la partida/juego:
func set_game() -> void:
	self.character = PlayerSession.character
	
	self.set_bonus()
	self.show_icons()
	
	# Se imprime el puntaje:
	self.score_label.print_score()
	self.score_flash_label.set("theme_override_colors/font_color", Color.DARK_GREEN)
	
	# Se cargan las respuestas:
	self.load_answers()


# Carga las respuestas en los botones:
func load_answers() -> void:
	# Se cargan las respuestas:
	var correct_answer: Dictionary = CharactersData.characters[self.character].correct_answer
	self.answers.append(correct_answer)
	var wrong_answer_1: Dictionary = CharactersData.characters[self.character].wrong_answers[0]
	self.answers.append(wrong_answer_1)
	var wrong_answer_2: Dictionary = CharactersData.characters[self.character].wrong_answers[1]
	self.answers.append(wrong_answer_2)
	var wrong_answer_3: Dictionary = CharactersData.characters[self.character].wrong_answers[2]
	self.answers.append(wrong_answer_3)

	# Se cambia la semilla:
	randomize()
	
	# Se mezcla el arreglo:
	self.answers.shuffle()
	
	# A cada botón se le asigna una respuesta:
	var count: int = 0
	for answer in self.answers:
		var button = self.buttons[count]
		if answer != correct_answer:
			button.construct(answer)
		else:
			button.construct(answer)
			button.defeated = true
		count += 1


func set_music():
	# Se cambia la música:
	var current_position: float = 0
	var pitch: float = 1.0
	var volume: float = 0
	BackgroundMusic.change_song(BackgroundMusic.Songs.FUNICULI_FUNICULA, current_position, pitch, volume)


# Otorga un puntaje basándose en el tiempo:
func reduce_default_score() -> void:
	@warning_ignore("integer_division")
	PlayerSession.score += (self.default_score/self.clock.minutes)*CharactersData.characters[self.character].bonus_multiplier


# Cambia el color del puntaje según el tiempo y la dificultad:
func change_score_color() -> void:
	var pivot1: int
	var pivot2: int
	var pivot3: int
	var pivot4: int
	match PlayerSession.difficulty:
		"medium":
			pivot1 = 12000
		"hard":
			pivot1 = 15000
		_:
			pivot1 = 10000
	pivot2 = pivot1-1250
	pivot3 = pivot2-1250
	pivot4 = pivot3-1250
	
	
	# Se cambian los colores del score_flash_label de acuerdo a default_score:
	if self.default_score >= pivot1:
		self.score_flash_label.set("theme_override_colors/font_color", Color.DARK_GREEN)
	elif self.default_score >= pivot2:
		self.score_flash_label.set("theme_override_colors/font_color", Color.BLUE)
	elif self.default_score >= pivot3:
		self.score_flash_label.set("theme_override_colors/font_color", Color.BLUE_VIOLET)
	elif self.default_score >= pivot4:
		self.score_flash_label.set("theme_override_colors/font_color", Color.CORAL)
	else:
		self.score_flash_label.set("theme_override_colors/font_color", Color.RED)


# Imprime el puntaje:
func print_score() -> void:
	self.change_score_color()
	Sfx.play_sound(Sfx.Sounds.SCORE)
	
	# Se imprime el puntaje nuevo:
	self.score_flash_label.text = "+%s" % (self.default_score*CharactersData.characters[self.character].bonus_multiplier)
	self.score_label_player.play("fade_out")
	self.score_label.print_score()


# Obtiene el puntaje del nivel:
func set_score() -> void:
	# Test debug:
	print_debug("El personaje es %s y es %s" % [CharactersData.characters[character].name, CharactersData.characters[character].defeated])
	
	# Se valida si se obtuvieron los puntos correctos:
	if self.defeated and PlayerSession.difficulty != "easy" \
	and self.extras_container.correctAnswer:
		if self.clock.minutes < 1:
			PlayerSession.score += self.default_score*CharactersData.characters[self.character].bonus_multiplier
		else:
			self.reduce_default_score()
	elif self.defeated and PlayerSession.difficulty == "easy":
		if self.clock.minutes < 1:
			PlayerSession.score += self.default_score*CharactersData.characters[self.character].bonus_multiplier
		else:
			self.reduce_default_score()


# Función que obtiene el score al haber presionado AcceptButton:
func _on_accept_button_pressed():
	# Se obtiene el puntaje:
	self.set_score()
	if self.defeated:
		# Se muestra el puntaje obtenido en score_flash_label:
		self.print_score()
		print_debug("The character is dead :v")
	# Se espera(n) 1 segundo(s) antes de continuar:
	await get_tree().create_timer(1).timeout
	# Se mueve al siguiente personaje:
	PlayerSession.next_character()
	# Se va hacia la cinemática de salida:
	SceneTransition.change_scene(self.outro_cutscene)


func _on_answer_button_1_pressed() -> void:
	if PlayerSession.difficulty == "easy":
		self.defeated = self.answer_button_1.defeated
	elif self.answer_button_1.defeated and self.extras_container.correctAnswer:
		self.defeated = true
	# Test debug:
	print_debug("Defeated: %s" %self.defeated)
	CharactersData.characters[self.character].defeated = self.defeated
	print_debug("Character %s defeated: %s" %[self.character, CharactersData.characters[self.character].defeated])


func _on_answer_button_2_pressed() -> void:
	if PlayerSession.difficulty == "easy":
		self.defeated = self.answer_button_2.defeated
	elif self.answer_button_2.defeated and self.extras_container.correctAnswer:
		self.defeated = true
	# Test debug:
	print_debug("Defeated: %s" %self.defeated)
	CharactersData.characters[self.character].defeated = self.defeated
	print_debug("Character %s defeated: %s" %[self.character, CharactersData.characters[self.character].defeated])


func _on_answer_button_3_pressed() -> void:
	if PlayerSession.difficulty == "easy":
		self.defeated = self.answer_button_3.defeated
	elif self.answer_button_3.defeated and self.extras_container.correctAnswer:
		self.defeated = true
	# Test debug:
	print_debug("Defeated: %s" %self.defeated)
	CharactersData.characters[self.character].defeated = self.defeated
	print_debug("Character %s defeated: %s" %[self.character, CharactersData.characters[self.character].defeated])


func _on_answer_button_4_pressed() -> void:
	if PlayerSession.difficulty == "easy":
		self.defeated = self.answer_button_4.defeated
	elif self.answer_button_4.defeated and self.extras_container.correctAnswer:
		self.defeated = true
	# Test debug:
	print_debug("Defeated: %s" %self.defeated)
	CharactersData.characters[self.character].defeated = self.defeated
	print_debug("Character %s defeated: %s" %[self.character, CharactersData.characters[self.character].defeated])


# Si se desactiva el menú de pausa:
func _on_pause_finished() -> void:
	self.answer_button_1.grab_focus()
	self.clock.continue_clock()
	self.pause.hide()


func _on_pause_btn_pressed() -> void:
	if !self.pause.is_active():
			self.clock.stop()
			self.pause.show_menu()


# Cuando se llegue a un minuto nuevo se aumenta la velocidad de la música:
func _on_clock_new_minute_reached() -> void:
	# Se aumenta el pitch_scale de la música por cada minuto de juego:
	self.current_pitch += 0.1
	BackgroundMusic.change_pitch(self.current_pitch)
