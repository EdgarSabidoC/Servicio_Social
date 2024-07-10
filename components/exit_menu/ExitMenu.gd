extends Control

@onready var yes_btn: Button = $ExitMenu/OptionsContainer/YesBtn
@onready var no_btn: Button = $ExitMenu/OptionsContainer/NoBtn


signal yes_pressed
signal no_pressed


func _on_yes_btn_pressed() -> void:
	self.yes_pressed.emit()


func _on_no_btn_pressed() -> void:
	self.no_pressed.emit()


func _on_visibility_changed() -> void:
	if self.is_visible_in_tree() and !Mouse.mouse_mode_activated:
		self.yes_btn.grab_focus()
