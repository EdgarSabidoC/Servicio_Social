extends Control

@onready var is_pausable_scene: bool = false
@onready var is_pause_active: bool = false
@onready var continue_btn: Button = $VBoxContainer/ContinueBtn
@onready var main_menu: PackedScene = load("res://scenes/main_menu/MainScene.tscn")


# Señal que es lanzada cuando se finaliza la pausa:
signal finished()


func _ready() -> void:
	self.hide()


func show_menu():
	is_pause_active = true
	self.show()


func hide_menu():
	is_pause_active = false
	self.hide()


# Retorna si la pausa está activa o no:
func is_active() -> bool:
	return is_pause_active


func _on_continue_btn_pressed() -> void:
	# Test debug:
	print_debug("Se desactivó la pausa")
	self.hide_menu()	
	self.finished.emit()


func _on_main_menu_btn_pressed() -> void:
	is_pause_active = false
	self.finished.emit()
	SceneTransition.change_scene(main_menu)
