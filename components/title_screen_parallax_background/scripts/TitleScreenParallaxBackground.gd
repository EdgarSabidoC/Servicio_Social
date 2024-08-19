extends Node2D

@onready var parallax_background: ParallaxBackground = $ParallaxBackground

var scroll_x = 0
@export var speed: int = 20

func _process(delta):	
	# Scroll background
	scroll_x -= 20 * delta
	parallax_background.scroll_offset.x = scroll_x
