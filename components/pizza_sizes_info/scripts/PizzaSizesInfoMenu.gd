extends Control

@onready var back_btn: Button = $BackBtn
@onready var back_btn_text_changed: bool = false
@onready var sizes: Dictionary
@onready var sizes_label: RichTextLabel = $SizesTexture/Sizes


signal back_btn_pressed


func _ready() -> void:
	self.sizes = self.sizes_label.get_sizes()


func _on_back_btn_pressed() -> void:
	Sfx.play_sound(Sfx.Sounds.BUTTON_ACCEPT)
	self.hide()
	back_btn_pressed.emit()


func _on_back_btn_visibility_changed() -> void:
	if self.back_btn and self.is_visible_in_tree():
		self.back_btn.grab_focus()
