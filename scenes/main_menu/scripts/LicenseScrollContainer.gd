extends ScrollContainer

@onready var license_text = $LicenseMarginContainer/LicenseText

func _ready() -> void:
	var height: int = license_text.get_content_height()
	var width: int = license_text.get_content_width()
	var minimum_size: Vector2 = Vector2(height, width)
	self.custom_minimum_size = minimum_size
