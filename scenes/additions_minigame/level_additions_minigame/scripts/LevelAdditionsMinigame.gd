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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Se inicializa el puntaje en 0:
	PlayerSession.score = 0
	#if !Mouse.mouse_mode_activated:
		#disable_buttons()
	#else:
		#self.accept_btn.grab_focus()
	self.accept_btn.grab_focus()
	

func _process(_delta: float) -> void:
	if total_label.text.length() > 12:
		disable_buttons()
	elif !buttons_are_enabled:
		enable_buttons()


func _input(event: InputEvent) -> void:
	pass


func disable_buttons() -> void:
	buttons_are_enabled = false
	for button in buttons:
		button.disabled = true


func enable_buttons() -> void:
	if buttons_are_enabled:
		for button in buttons:
			button.disabled = false
			buttons_are_enabled = true


func _on_button_dot_pressed() -> void:
	if !total_label.text.contains("."):
		total_label.text += "."


func _on_button_0_pressed() -> void:
	total_label.text += "0"


func _on_button_1_pressed() -> void:
	total_label.text += "1"


func _on_button_2_pressed() -> void:
	total_label.text += "2"


func _on_button_3_pressed() -> void:
	total_label.text += "3"


func _on_button_4_pressed() -> void:
	total_label.text += "4"


func _on_button_5_pressed() -> void:
	total_label.text += "5"


func _on_button_6_pressed() -> void:
	total_label.text += "6"


func _on_button_7_pressed() -> void:
	total_label.text += "7"


func _on_button_8_pressed() -> void:
	total_label.text += "8"


func _on_button_9_pressed() -> void:
	total_label.text += "9"


func _on_button_clear_pressed() -> void:
	total_label.text = total_label.text.left(-1)
