extends Control
@onready var rich_text_label = $ScrollContainer/MarginContainer/RichTextLabel

func print_text(text: String) -> void:
	if rich_text_label:
		self.rich_text_label.text = text
