extends Control

@onready var yes_btn: Button = $ExitMenu/OptionsContainer/YesBtn
@onready var no_btn: Button = $ExitMenu/OptionsContainer/NoBtn

signal yes_pressed
signal no_pressed


func _on_yes_btn_pressed() -> void:
	self.yes_pressed.emit()
	Sfx.play_sound(Sfx.Sounds.BUTTON_ACCEPT, 15)
	await get_tree().create_timer(0.5).timeout
	# Evita que al presionar enter se propague el evento:
	get_tree().get_root().set_input_as_handled()


func _on_no_btn_pressed() -> void:
	self.no_pressed.emit()
	Sfx.play_sound(Sfx.Sounds.RESUME_PAUSE, 15)
	await get_tree().create_timer(0.5).timeout
	# Evita que al presionar enter se propague el evento:
	get_tree().get_root().set_input_as_handled()


func _on_visibility_changed() -> void:
	if self.is_visible_in_tree():
		Sfx.play_sound(Sfx.Sounds.PAUSE_MENU)
		self.yes_btn.grab_focus()
