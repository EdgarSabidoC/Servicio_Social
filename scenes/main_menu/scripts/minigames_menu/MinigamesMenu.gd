extends VBoxContainer

@onready var menu_textbox: MarginContainer = $MarginContainer/MenuTextbox


func _ready() -> void:
	menu_textbox.print_message(menu_textbox.default_text, "c")
