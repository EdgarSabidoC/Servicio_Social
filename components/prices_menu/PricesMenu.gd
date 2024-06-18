extends Control

signal back_btn_pressed


func _ready() -> void:
	self.hide()


func _on_back_btn_pressed() -> void:
	self.hide()
	back_btn_pressed.emit()
