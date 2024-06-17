extends Button

@onready var ticket_animation_sprite: AnimatedSprite2D = $"../../TicketAnimationSprite"


func _on_pressed() -> void:
	ticket_animation_sprite.show()
	ticket_animation_sprite.animation = "default"
	ticket_animation_sprite.play()
