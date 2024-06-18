extends Control

@onready var is_pausable_scene: bool = false
@onready var is_pause_active: bool = false
@onready var continue_btn: Button = $VBoxContainer/ContinueBtn
@onready var main_menu: PackedScene = load("res://scenes/main_menu/MainScene.tscn")


# Señal que es lanzada cuando se finaliza la pausa:
signal finished()


# Función que muestra el menú de pausa:
func show_menu():
	is_pause_active = true
	self.show()


# Función que oculta el menú de pausa:
func hide_menu():
	is_pause_active = false
	self.hide()


# Retorna si la pausa está activa o no:
func is_active() -> bool:
	return is_pause_active


# Señal que es lanzada cuando se presiona el continue_btn:
func _on_continue_btn_pressed() -> void:
	self.hide_menu()	
	self.finished.emit()


# Señal que es lanzada cuando se presiona el main_menu_btn:
func _on_main_menu_btn_pressed() -> void:
	is_pause_active = false
	self.finished.emit()
	SceneTransition.change_scene(main_menu)
	PlayerSession.clear_player_session()


# Señal que es lanzada cuando se cambia la visibilidad del continue_btn:
func _on_continue_btn_visibility_changed() -> void:
	if self.is_visible_in_tree() and !Mouse.mouse_mode_activated:
		continue_btn.grab_focus()
