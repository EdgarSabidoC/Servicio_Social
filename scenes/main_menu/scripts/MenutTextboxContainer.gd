extends VBoxContainer
@onready var menu_textbox = $MenuTextbox


func _ready() -> void:
	self.menu_textbox.get_child(0).add_theme_color_override("default_color", Color("ffffff")) # Color verde
