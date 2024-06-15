extends Control

@onready var yes_btn: Button = $ExitMenu/OptionsContainer/YesBtn
@onready var no_btn: Button = $ExitMenu/OptionsContainer/NoBtn


signal yes_pressed
signal no_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_yes_btn_pressed() -> void:
	yes_pressed.emit()


func _on_no_btn_pressed() -> void:
	no_pressed.emit()


func _on_visibility_changed() -> void:
	if self.is_visible_in_tree() and !Mouse.mouse_mode_activated:
		yes_btn.grab_focus()
