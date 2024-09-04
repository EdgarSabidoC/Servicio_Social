extends Control

@onready var background_texture_rect: TextureRect = $BackgroundTextureRect
@onready var title_label: Label = $TitleLabel
@onready var score_label: RichTextLabelTextFlash = $ScoreLabel
@onready var restart_btn: Button = $RestartBtn
@onready var return_btn: Button = $ReturnBtn

@onready var main_menu: PackedScene = load("res://scenes/main_menu/MainScene.tscn")


signal restart_game


func _on_restart_btn_pressed() -> void:
	Sfx.play_sound(Sfx.Sounds.BUTTON_ACCEPT)
	self.hide()
	self.score_label.text = "[center]00000000[/center]"
	self.restart_game.emit()


func _on_return_btn_pressed() -> void:
	Sfx.play_sound(Sfx.Sounds.SCREEN_PRESS)
	# Si está activado el modo práctica se desactiva:
	if PlayerSession.is_practice_mode():
		PlayerSession.change_practice_mode()
	SceneTransition.change_scene(main_menu)
	PlayerSession.clear_player_session()
	# Se cambia la música del minijuego a la del menú principal:
	var volume: float = -10
	var current_position: float = 0
	BackgroundMusic.start_menu_song(volume, current_position)


func _on_visibility_changed() -> void:
	if self.is_visible_in_tree():
		self.restart_btn.grab_focus()


# Imprime el puntaje final en la etiqueta ScoreLabel:
func print_score(score: int = PlayerSession.score) -> void:
	Sfx.play_sound(Sfx.Sounds.SCORE_SCREEN)
	self.score_label.text = "[center]%08d[/center]" % score
