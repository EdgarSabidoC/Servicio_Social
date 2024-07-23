extends Control

@onready var is_pausable_scene: bool = false
@onready var is_pause_active: bool = false
@onready var continue_btn: Button = $VBoxContainer/ContinueBtn
@onready var main_menu: PackedScene = load("res://scenes/main_menu/MainScene.tscn")


# Señal que es lanzada cuando se finaliza la pausa:
signal finished()


# Función que muestra el menú de pausa:
func show_menu():
	self.is_pause_active = true
	self.show()


# Función que oculta el menú de pausa:
func hide_menu():
	self.is_pause_active = false
	self.hide()


# Retorna si la pausa está activa o no:
func is_active() -> bool:
	return self.is_pause_active


# Señal que es lanzada cuando se presiona el continue_btn:
func _on_continue_btn_pressed() -> void:
	self.hide_menu()	
	self.finished.emit()


# Señal que es lanzada cuando se presiona el main_menu_btn:
func _on_main_menu_btn_pressed() -> void:
	# Si está activado el modo práctica:
	if PlayerSession.is_practice_mode():
		PlayerSession.change_practice_mode()
	self.is_pause_active = false
	self.finished.emit()
	SceneTransition.change_scene(main_menu)
	PlayerSession.clear_player_session()
	# Se cambia la música del minijuego a la del menú principal:
	var volume: float = -10
	var current_position: float = 0
	BackgroundMusic.start_menu_song(volume, current_position)


func _on_visibility_changed() -> void:
	if self.is_visible_in_tree() and !Mouse.mouse_mode_activated:
		self.continue_btn.grab_focus()
	else:
		self.continue_btn.release_focus()
