extends MarginContainer

@onready var moving_text: RichTextLabel = $MovingText
@onready var dialogue_box: Control = $"../.."

func _on_moving_text_end_of_text() -> void:
	dialogue_box.eof = true
