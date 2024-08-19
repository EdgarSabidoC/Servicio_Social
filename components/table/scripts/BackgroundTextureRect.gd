extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pivot_offset = self.custom_minimum_size/2

