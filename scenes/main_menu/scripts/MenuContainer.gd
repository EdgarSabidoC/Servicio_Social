extends Control

@onready var menu_textbox: MarginContainer = $MenuTextbox/MarginContainer/MenuTextbox


signal main_window_size_changed()


func _ready() -> void:
	# Se imprime el mensaje por defecto en la caja de texto del menú:
	self.menu_textbox.print_message(self.menu_textbox.default_text)
