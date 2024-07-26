extends Control

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var menu_textbox: MarginContainer = $MenuTextbox
@onready var texture_rect: TextureRect = $TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.animated_sprite_2d.play()

