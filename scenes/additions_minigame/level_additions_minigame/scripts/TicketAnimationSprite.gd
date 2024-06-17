extends AnimatedSprite2D

@onready var total_label: Label = $"../TotalLabel"


func _on_animation_finished() -> void:
	total_label.show()
	print_debug("Finalizó")
