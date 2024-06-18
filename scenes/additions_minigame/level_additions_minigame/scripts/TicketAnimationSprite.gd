extends AnimatedSprite2D

@onready var cont: int = 0
@onready var total_label: Label = $"../TotalLabel"
@onready var animation_player: AnimationPlayer = $"../TotalLabel/AnimationPlayer"
var changed: bool = false


func _on_frame_changed() -> void:
	if self.frame == 1:
		total_label.show()
		animation_player.play("default")
