extends Control

@onready var yes_btn: Button = $ExitMenu/OptionsContainer/YesBtn
@onready var no_btn: Button = $ExitMenu/OptionsContainer/NoBtn

signal yes_pressed
signal no_pressed


func _on_yes_btn_pressed() -> void:
	if PlayerSession.is_practice_mode():
		# Si es el modo práctica se desactiva:
		PlayerSession.change_practice_mode()
	self.yes_pressed.emit()
	# Evita que al presionar enter se propague el evento:
	get_tree().get_root().set_input_as_handled()


func _on_no_btn_pressed() -> void:
	self.no_pressed.emit()
	# Evita que al presionar enter se propague el evento:
	get_tree().get_root().set_input_as_handled()


func _on_visibility_changed() -> void:
	if self.is_visible_in_tree():
		self.yes_btn.grab_focus()
