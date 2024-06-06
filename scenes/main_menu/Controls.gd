extends TabBar

@onready var settings = %Settings
@onready var up = $ControlsOptionsContainer/MarginContainer/HBoxContainer/ActionButtonContainer/Up
@onready var mouse_mode = $ControlsOptionsContainer/MarginContainer/HBoxContainer/ActionButtonContainer/MouseMode


func _on_visibility_changed():
	print_debug("Visibility changed")
	if !Mouse.mouse_mode_activated:
		up.grab_focus()
	else:
		mouse_mode.grab_focus()
