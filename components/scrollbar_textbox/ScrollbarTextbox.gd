extends Control
@onready var rich_text_label = $ScrollContainer/MarginContainer/RichTextLabel

func print_text(text: String) -> void:
	rich_text_label.text = text
