extends CheckButton

@onready var up_button = $"../Up"
@onready var down_button = $"../Down"
@onready var left_button = $"../Left"
@onready var right_button = $"../Right"
@onready var accept_button = $"../Accept"
@onready var pause_button = $"../Pause"
@onready var up_label = $"../../ControlsLabelsContainer/Up"
@onready var down_label = $"../../ControlsLabelsContainer/Down"
@onready var left_label = $"../../ControlsLabelsContainer/Left"
@onready var right_label = $"../../ControlsLabelsContainer/Right"
@onready var accept_label = $"../../ControlsLabelsContainer/Accept"
@onready var pause_label = $"../../ControlsLabelsContainer/Pause"

func _ready() -> void:
	if Mouse.mouse_mode_activated:
		self.button_pressed = true
		up_button.hide()
		down_button.hide()
		left_button.hide()
		right_button.hide()
		accept_button.hide()
		pause_button.hide()
		up_label.hide()
		down_label.hide()
		left_label.hide()
		right_label.hide()
		accept_label.hide()
		pause_label.hide()
	else:
		self.button_pressed = false
		up_button.show()
		down_button.show()
		left_button.show()
		right_button.show()
		accept_button.show()
		pause_button.show()
		up_label.show()
		down_label.show()
		left_label.show()
		right_label.show()
		accept_label.show()
		pause_label.show()


# Activa o desactiva el modo mouse:
func _on_pressed():
	Mouse.change_mode()
	if Mouse.mouse_mode_activated:
		Mouse.disable_actions()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		up_button.hide()
		down_button.hide()
		left_button.hide()
		right_button.hide()
		accept_button.hide()
		pause_button.hide()
		up_label.hide()
		down_label.hide()
		left_label.hide()
		right_label.hide()
		accept_label.hide()
		pause_label.hide()
	else:
		self.grab_focus()
		Mouse.enable_actions()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		up_button.show()
		down_button.show()
		left_button.show()
		right_button.show()
		accept_button.show()
		pause_button.show()
		up_label.show()
		down_label.show()
		left_label.show()
		right_label.show()
		accept_label.show()
		pause_label.show()
