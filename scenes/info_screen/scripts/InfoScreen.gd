extends Control

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var texture_rect: TextureRect = $TextureRect
@onready var dialogue_box: Control = $DialogueBox
@export_multiline var text: String = ""
@onready var continue_btn: Button = $ContinueBtn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.animated_sprite_2d.play()
	self.dialogue_box.start()


func _on_dialogue_box_dialogue_box_closed() -> void:
	self.continue_btn.show()


func _on_continue_btn_pressed() -> void:
	self.hide()
