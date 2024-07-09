extends Node2D

@onready var pause: Control = $CanvasLayer/Pause
@onready var clock: Clock = $CanvasLayer/Clock


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		if !self.pause.is_active():
			self.clock.stop()
			self.pause.show()


func _on_pause_finished() -> void:
	if !Mouse.mouse_mode_activated:
		pass
	self.clock.continue_clock()
	self.pause.hide()


func _on_pause_btn_pressed() -> void:
	if !self.pause.is_active():
			self.clock.stop()
			self.pause.show()
