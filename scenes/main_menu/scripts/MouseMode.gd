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
@onready var scroll_container: ScrollContainer = $"../../.."


func _ready() -> void:
	if Mouse.mouse_mode_activated:
		self.button_pressed = true
		_hide_buttons_and_labels()
	else:
		self.button_pressed = false
		_show_buttons_and_labels()


# Activa o desactiva el modo mouse:
func _on_pressed():
	Mouse.change_mode()
	if Mouse.mouse_mode_activated:
		_hide_buttons_and_labels()
		%BackButton.show()
	else:
		self.grab_focus()
		self._show_buttons_and_labels()
		self.up_button.grab_focus()
		%BackButton.hide()


# Oculta botones y etiquetas
func _hide_buttons_and_labels():
	self.up_button.hide()
	self.down_button.hide()
	self.left_button.hide()
	self.right_button.hide()
	self.accept_button.hide()
	self.pause_button.hide()
	self.up_label.hide()
	self.down_label.hide()
	self.left_label.hide()
	self.right_label.hide()
	self.accept_label.hide()
	self.pause_label.hide()


# Muestra botones y etiquetas
func _show_buttons_and_labels():
	self.up_button.show()
	self.down_button.show()
	self.left_button.show()
	self.right_button.show()
	self.accept_button.show()
	self.pause_button.show()
	self.up_label.show()
	self.down_label.show()
	self.left_label.show()
	self.right_label.show()
	self.accept_label.show()
	self.pause_label.show()
