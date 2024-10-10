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
@onready var dialogue_box: Control = $DialogueBox
@onready var oppossum_message: String = ""
@onready var pizza_sizes_btn: Button = $PizzaSizesBtn
@onready var pizza_sizes_info_menu: Control = $PizzaSizesInfoMenu


func _ready() -> void:
	# Se oculta el cuadro de diálogo:
	self.dialogue_box.hide()
	if Mouse.mouse_mode_activated:
		Mouse.enable_actions() # Se habilitan las teclas
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
	self.accept_btn.grab_focus()
	

func _on_accept_btn_pressed() -> void:
	# Se carga el mensaje de aceptación del pedido:
	self.get_rand_dialogue()
	Sfx.play_sound(Sfx.Sounds.BUTTON_ACCEPT)
	self.option_buttons_container.hide()
	self.options_label.hide()
	self.dialogue_box.start()


func _on_reject_btn_pressed() -> void:
	Sfx.play_sound(Sfx.Sounds.BUTTON_REJECT)
	# Se cambia el tiempo:
	self.time = 0
	# Se cambia a la siguiente escena:
	self.change_to_next_scene(self.outro_cutscene, "direct")
	CharactersData.characters[PlayerSession.character].rejected = true


func _on_dialogue_box_dialogue_box_closed() -> void:
	# Se cambia a la siguiente escena:
	self.change_to_next_scene(self.level_fractions_minigame)


func get_rand_dialogue() -> void:
	# Diálogos genéricos para cuando se acepta la orden
	var accept_dialogues: Array[String] = [
		"¡Claro! En un momento estará lista su orden...",
		"¡Por su puesto! Me pongo manos a la masa...",
		"¡Muy bien! Le avisaré cuando su orden esté lista...",
		"¡Excelente elección! Nosotros le avisamos, tome asiento, por favor.",
		"¡Entendido! Enseguida estará su orden lista..."
	]

	self.oppossum_message = accept_dialogues[randi_range(0, accept_dialogues.size()-1)]
	self.dialogue_box.load_message(self.oppossum_message)


func _on_pizza_sizes_info_menu_back_btn_pressed() -> void:
	self.pizza_sizes_info_menu.hide()


func _on_pizza_sizes_info_menu_visibility_changed() -> void:
	if self.pizza_sizes_info_menu.is_visible_in_tree():
		get_tree().paused = true
	else:
		get_tree().paused = false
	if self.accept_btn:
		self.accept_btn.grab_focus()


func _on_pizza_sizes_btn_pressed() -> void:
	Sfx.play_sound(Sfx.Sounds.INFO_SCREEN, 15)
	self.pizza_sizes_info_menu.show()
