extends Node2D

# Suma total máxima en difícil: $4994.28


@onready var total_label: Label = $CanvasLayer/TotalLabel
@onready var button_dot: Button = $CanvasLayer/GridContainer/ButtonDot
@onready var button_0: Button = $CanvasLayer/GridContainer/Button0
@onready var button_1: Button = $CanvasLayer/GridContainer/Button1
@onready var button_2: Button = $CanvasLayer/GridContainer/Button2
@onready var button_3: Button = $CanvasLayer/GridContainer/Button3
@onready var button_4: Button = $CanvasLayer/GridContainer/Button4
@onready var button_5: Button = $CanvasLayer/GridContainer/Button5
@onready var button_6: Button = $CanvasLayer/GridContainer/Button6
@onready var button_7: Button = $CanvasLayer/GridContainer/Button7
@onready var button_8: Button = $CanvasLayer/GridContainer/Button8
@onready var button_9: Button = $CanvasLayer/GridContainer/Button9
@onready var button_clear: Button = $CanvasLayer/GridContainer/ButtonClear
@onready var buttons_are_enabled: bool = true
@onready var buttons: Array[Button] = [button_dot, button_clear, button_0, button_1, button_2, button_3, button_4, button_5, button_6, button_7, button_8, button_9]
@onready var accept_btn: Button = $CanvasLayer/VBoxContainer/AcceptBtn
@onready var clear_btn: Button = $CanvasLayer/VBoxContainer/ClearBtn
@onready var prices_btn: Button = $CanvasLayer/PricesBtn
@onready var pause: Control = $CanvasLayer/Pause
@onready var clock: Clock = $CanvasLayer/Clock
@onready var score_label: Label = $CanvasLayer/ScorePanel/ScoreLabel
@onready var prices_menu: Control = $CanvasLayer/PricesMenu
@onready var current_pitch = 1.0
@onready var digits_len: int = 6
@onready var rich_text_label: RichTextLabel = $CanvasLayer/RichTextLabel
@onready var total: float = 0
@onready var prices: Array[float]
@onready var pause_btn: Button = $CanvasLayer/PauseBtn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Se inicializa el puntaje en 0:
	PlayerSession.score = 0

	match PlayerSession.difficulty:
		"easy":
			self.clock.time = 120
		"medium":
			self.clock.time = 90
		"hard":
			self.clock.time = 60

	# Se imprime el puntaje:
	self.score_label.print_score()

	# Se muestra la orden:
	self.rich_text_label.text = self.generate_order()

	# Se activan los controles de pausa:
	if !self.pause.is_pausable_scene:
		self.pause.is_pausable_scene = true
	
	# Se desactivan los botones en el modo teclado:
	if !Mouse.mouse_mode_activated:
		self.buttons_are_enabled = false
		for button in self.buttons:
			button.disabled = true
	
	self.clock.stop()


func _process(_delta: float) -> void:
	if Mouse.mouse_mode_activated and self.total_label.text.length() > self.digits_len:
		self.disable_buttons()
	elif Mouse.mouse_mode_activated and !self.buttons_are_enabled:
		self.enable_buttons()
		
	# Se leen las entradas si está en modo teclado:
	if !Mouse.mouse_mode_activated:
		self.check_input_actions()

	if self.total_label.text.begins_with("."):
		self.total_label.text = "0."
	
	if Input.is_action_just_pressed("ui_pause") and !prices_menu.is_visible_in_tree():
		if !self.pause.is_active():
			self.clock.stop()
			self.pause.show()
	elif Input.is_action_just_pressed("ui_delete"):
		self.total_label.text = self.total_label.text.left(-1)


# Genera un diccionario con datos aleatorios en un rango de 0 a 9:
func generate_order_data() -> Dictionary:
	return {"sp": randi_range(0,9), "mp": randi_range(0,9), \
			"bp":  randi_range(0,9), "ss":  randi_range(0,9), \
			"ms":  randi_range(0,9), "bs":  randi_range(0,9), \
			"sodas":  randi_range(0,9), "breads": randi_range(0,9)}


# Genera una etiqueta dinámica con datos aleatorios:
func generate_order_label() -> Dictionary:
	var small_pizza: String = "Pizzas pequeñas: %s\n"
	var medium_pizza: String = "Pizzas medianas: %s\n"
	var big_pizza: String = "Pizzas grandes: %s\n\n"
	var small_slice: String = "Rebanadas pequeñas: %s\n"
	var medium_slice: String = "Rebanadas medianas: %s\n"
	var big_slice: String = "Rebanadas grandes: %s\n\n"
	var sodas: String = "Refrescos: %s\n"
	var breads: String = "Órdenes de pan: %s\n"
	
	# Se generan los datos aleatorios:
	var data: Dictionary = self.generate_order_data()
	
	# Si está en dificultad fácil:
	for key in data.keys():
		self.total += data[key] * self.prices_menu.prices[key]
		match key:
			"sp":
				if PlayerSession.difficulty == "easy" and data[key] != 0:
					data[key] = small_pizza % data[key]
				elif PlayerSession.difficulty == "medium" or  PlayerSession.difficulty == "hard":
					data[key] = small_pizza % data[key]
				else:
					data[key] = ""
			"mp":
				if PlayerSession.difficulty == "easy" and data[key] != 0:
					data[key] = medium_pizza % data[key]
				elif PlayerSession.difficulty == "medium" or  PlayerSession.difficulty == "hard":
					data[key] = medium_pizza % data[key]
				else:
					data[key] = ""
			"bp":
				if PlayerSession.difficulty == "easy" and data[key] != 0:
					data[key] = big_pizza % data[key]
				elif PlayerSession.difficulty == "medium" or  PlayerSession.difficulty == "hard":
					data[key] = big_pizza % data[key]
				else:
					data[key] = ""
			"ss":
				if PlayerSession.difficulty == "easy" and data[key] != 0:
					data[key] = small_slice % data[key]
				elif PlayerSession.difficulty == "medium" or  PlayerSession.difficulty == "hard":
					data[key] = small_slice % data[key]
				else:
					data[key] = ""
			"ms":
				if PlayerSession.difficulty == "easy" and data[key] != 0:
					data[key] = medium_slice % data[key]
				elif PlayerSession.difficulty == "medium" or  PlayerSession.difficulty == "hard":
					data[key] = medium_slice % data[key]
				else:
					data[key] = ""
			"bs":
				if PlayerSession.difficulty == "easy" and data[key] != 0:
					data[key] = big_slice % data[key]
				elif PlayerSession.difficulty == "medium" or  PlayerSession.difficulty == "hard":
					data[key] = big_slice % data[key]
				else:
					data[key] = ""
			"sodas":
				if PlayerSession.difficulty == "easy" and data[key] != 0:
					data[key] = sodas % data[key]
				elif PlayerSession.difficulty == "medium" or  PlayerSession.difficulty == "hard":
					data[key] = sodas % data[key]
				else:
					data[key] = ""
			"breads":
				if PlayerSession.difficulty == "easy" and data[key] != 0:
					data[key] = breads % data[key]
				elif PlayerSession.difficulty == "medium" or  PlayerSession.difficulty == "hard":
					data[key] = breads % data[key]
				else:
					data[key] = ""
	
	return data


func generate_order() -> String:
	var text_data: Dictionary = self.generate_order_label()
	return "[left]{sp}{mp}{bp}{ss}{ms}{bs}{sodas}{breads}[/left]".format({"sp": text_data["sp"], \
																"mp": text_data["mp"], \
																"bp": text_data["bp"], \
																"ss": text_data["ss"], \
																"ms": text_data["ms"], \
																"bs": text_data["bs"], \
																"sodas": text_data["sodas"], \
																"breads": text_data["breads"]})


# Verifica la acción de entrada e imprime la acción correspondiente en total_label:
func check_input_actions() -> void:
	if !self.buttons_are_enabled or self.total_label.text.length() > self.digits_len:
		# Si los botones de la caja registradora están bloqueados o el largo
		# de los dígitos superó el límite:
		return
	if Input.is_action_just_pressed("num_0"):
		self.total_label.text += "0"
	elif Input.is_action_just_pressed("num_1"):
		self.total_label.text += "1"
	elif Input.is_action_just_pressed("num_2"):
		self.total_label.text += "2"
	elif Input.is_action_just_pressed("num_3"):
		self.total_label.text += "3"
	elif Input.is_action_just_pressed("num_4"):
		self.total_label.text += "4"
	elif Input.is_action_just_pressed("num_5"):
		self.total_label.text += "5"
	elif Input.is_action_just_pressed("num_6"):
		self.total_label.text += "6"
	elif Input.is_action_just_pressed("num_7"):
		self.total_label.text += "7"
	elif Input.is_action_just_pressed("num_8"):
		self.total_label.text += "8"
	elif Input.is_action_just_pressed("num_9"):
		self.total_label.text += "9"
	elif Input.is_action_just_pressed("period"):
		if !self.total_label.text.contains("."):
			self.total_label.text += "."


# Deshabilita los botones:
func disable_buttons() -> void:
	self.buttons_are_enabled = false
	for button in self.buttons:
		button.disabled = true


# Habilita los botones:
func enable_buttons() -> void:
	if !self.buttons_are_enabled:
		for button in self.buttons:
			button.disabled = false
		self.buttons_are_enabled = true


func _on_button_dot_pressed() -> void:
	if !self.total_label.text.contains("."):
		self.total_label.text += "."


func _on_button_0_pressed() -> void:
	self.total_label.text += "0"


func _on_button_1_pressed() -> void:
	self.total_label.text += "1"


func _on_button_2_pressed() -> void:
	self.total_label.text += "2"


func _on_button_3_pressed() -> void:
	self.total_label.text += "3"


func _on_button_4_pressed() -> void:
	self.total_label.text += "4"


func _on_button_5_pressed() -> void:
	self.total_label.text += "5"


func _on_button_6_pressed() -> void:
	self.total_label.text += "6"


func _on_button_7_pressed() -> void:
	self.total_label.text += "7"


func _on_button_8_pressed() -> void:
	self.total_label.text += "8"


func _on_button_9_pressed() -> void:
	self.total_label.text += "9"


func _on_button_clear_pressed() -> void:
	self.total_label.text = self.total_label.text.left(-1)


func _on_pause_finished() -> void:
	if !Mouse.mouse_mode_activated:
		self.accept_btn.grab_focus()
	self.clock.continue_clock()
	self.pause.hide()


func _on_pause_btn_pressed() -> void:
	if !self.pause.is_active():
		if !Mouse.mouse_mode_activated:
			self.pause.continue_btn.grab_focus()
		else:
			self.pause_btn.release_focus()
		self.clock.stop()
		self.pause.show()


# Cuando se llegue a un minuto nuevo se aumenta la velocidad de la música:
func _on_clock_new_minute_reached() -> void:
	# Se aumenta el pitch_scale de la música por cada minuto de juego:
	self.current_pitch += 0.1
	BackgroundMusic.change_pitch(self.current_pitch)


func _on_prices_btn_pressed() -> void:
	self.prices_menu.show()
	self.clock.stop()


func _on_prices_menu_back_btn_pressed() -> void:
	self.prices_menu.hide()
	self.clock.continue_clock()


func _on_accept_btn_pressed() -> void:
	if float(self.total_label.text) == self.total:
		PlayerSession.score += 10000 # Se actualiza el puntaje
		self.score_label.print_score() # Se imprime el puntaje
		print_debug("Son iguales [total: %s, total_label_text: %s]" %[self.total, float(self.total_label.text)])
		# Se genera una nueva orden:
		self.rich_text_label.text = self.generate_order()

func _on_clock_countdown_finished() -> void:
	print_debug("Finalizó el tiempo")


func _on_prices_menu_visibility_changed() -> void:
	if self.accept_btn and !Mouse.mouse_mode_activated:
		self.accept_btn.grab_focus()


func _on_pause_visibility_changed() -> void:
	if !self.pause.is_visible_in_tree() and !Mouse.mouse_mode_activated:
		self.accept_btn.grab_focus()
