extends Control

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var texture_rect: TextureRect = $TextureRect
@onready var dialogue_box: Control = $DialogueBox
@export_multiline var fractions_text: String = ""
@export_multiline var additions_text: String = ""
@export_multiline var coordinates_text: String = ""
@export_multiline var symmetry_text: String = ""
@onready var continue_btn: Button = $ContinueBtn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.animated_sprite_2d.play()

	# Se carga el texto correspondiente al minijuego:
	match PlayerSession.current_minigame:
		PlayerSession.Minigames.FRACCTIONS:
			PlayerSession.fractions_info_screen = true
			self.dialogue_box.load_message(self.fractions_text)
		PlayerSession.Minigames.ADDITIONS:
			PlayerSession.additions_info_screen = true
			self.dialogue_box.load_message(self.additions_text)
		PlayerSession.Minigames.COORDINATES:
			PlayerSession.coordinates_info_screen = true
			self.dialogue_box.load_message(self.coordinates_text)
		PlayerSession.Minigames.SYMMETRY:
			PlayerSession.symmetry_info_screen = true
			self.dialogue_box.load_message(self.symmetry_text)
	self.dialogue_box.start()


func _on_dialogue_box_dialogue_box_closed() -> void:
	self.continue_btn.show()


func _on_continue_btn_pressed() -> void:
	self.queue_free() # La escena es destruida.
