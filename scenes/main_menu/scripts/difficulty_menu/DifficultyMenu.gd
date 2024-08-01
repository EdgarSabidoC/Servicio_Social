extends VBoxContainer

var last_size: Vector2i
var margin_value: int

@onready var menu_textbox: MarginContainer = $MarginContainer/MenuTextbox
@onready var easy_btn: Button = $EasyBtn


func _ready() -> void:
	menu_textbox.print_message(menu_textbox.default_text)

