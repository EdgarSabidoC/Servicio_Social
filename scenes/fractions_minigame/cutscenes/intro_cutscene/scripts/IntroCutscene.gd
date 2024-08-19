extends Control

var level_fractions_minigame: PackedScene = load("res://scenes/fractions_minigame/level_fractions_minigame/LevelFractionsMinigame.tscn")
var outro_cutscene: PackedScene = load("res://scenes/fractions_minigame/cutscenes/outro_cutscene/OutroCutscene.tscn")

@onready var music_starts_at: float = 0.5
@onready var scene_01: Control = $Scene01
@onready var scene_finished: bool = false
@onready var option_buttons_container: HBoxContainer = $OptionButtonsContainer
@onready var options_label: Label = $OptionsLabel
@onready var time: float = 1
@onready var accept_btn: Button = $OptionButtonsContainer/AcceptBtn


func _ready() -> void:
	# Se cambia la canción:
	BackgroundMusic.change_song(BackgroundMusic.Songs.O_SOLE_MIO_SOFT_PIANO, self.music_starts_at)


func _process(_delta: float) -> void:
	# Si la canción llega al segundo 44.5 se repite:
	if BackgroundMusic.get_playback_position() >= 45:
		BackgroundMusic.seek(self.music_starts_at)


func change_to_next_scene(scene: PackedScene, transition_type: String = "dissolve"):
	self.option_buttons_container.hide()
	self.options_label.hide()
	await get_tree().create_timer(self.time).timeout
	get_tree().root.set_input_as_handled()
	accept_event()
	# Moverse a la siguiente escena:
	SceneTransition.change_scene(scene, transition_type)


func _on_scene_01_finished() -> void:
	# Se muestran las opciones:
	self.options_label.show()
	self.option_buttons_container.show()
	
	# Se configura el modo teclado:
	if !Mouse.mouse_mode_activated:
		self.accept_btn.grab_focus()
	

func _on_accept_btn_pressed() -> void:
	# Se cambia a la siguiente escena:
	self.change_to_next_scene(self.level_fractions_minigame)


func _on_reject_btn_pressed() -> void:
	# Se cambia el tiempo:
	self.time = 0
	# Se cambia a la siguiente escena:
	self.change_to_next_scene(self.outro_cutscene, "direct")
	CharactersData.characters[PlayerSession.character].rejected = true
