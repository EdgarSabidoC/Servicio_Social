extends Node2D

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
@onready var buttons_are_enabled: bool = true
@onready var buttons: Array[Button] = [button_dot, button_0, button_1, button_2, button_3, button_4, button_5, button_6, button_7, button_8, button_9]
@onready var accept_btn: Button = $CanvasLayer/VBoxContainer/AcceptBtn
@onready var clear_btn: Button = $CanvasLayer/VBoxContainer/ClearBtn
@onready var prices_btn: Button = $CanvasLayer/PricesBtn
@onready var pause: Control = $CanvasLayer/Pause
@onready var clock: Clock = $CanvasLayer/Clock
@onready var score_label: Label = $CanvasLayer/ScorePanel/ScoreLabel
@onready var prices_menu: Control = $CanvasLayer/PricesMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Se inicializa el puntaje en 0:
	PlayerSession.score = 0
	
	# Se imprime el puntaje:
	self.score_label.print_score()
	
	# Se activan los controles de pausa:
	if !self.pause.is_pausable_scene:
		self.pause.is_pausable_scene = true
	#if !Mouse.mouse_mode_activated:
		#disable_buttons()
	#else:
		#self.accept_btn.grab_focus()
	self.accept_btn.grab_focus()
	

func _process(_delta: float) -> void:
	if self.total_label.text.length() > 12:
		disable_buttons()
	elif !self.buttons_are_enabled:
		enable_buttons()
	
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
			if self.total_label.text.begins_with("."):
				print_debug(self.total_label.text)
			else:
				self.total_label.text += "."
	elif Input.is_action_just_pressed("ui_pause"):
		if !self.pause.is_active():
			self.clock.stop()
			self.pause.show()
	


func disable_buttons() -> void:
	self.buttons_are_enabled = false
	for button in self.buttons:
		self.button.disabled = true


func enable_buttons() -> void:
	if self.buttons_are_enabled:
		for button in self.buttons:
			self.button.disabled = false
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
		self.answer_button_1.grab_focus()
	self.clock.continue_clock()
	self.pause.hide()


func _on_pause_btn_pressed() -> void:
	if !self.pause.is_active():
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
