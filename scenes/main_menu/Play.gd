extends Button

#var _move_to: PackedScene
@onready var hint: String = "Comienza a jugar."

func _ready() -> void:
	grab_focus()


func _on_pressed() -> void:
	MenuBackgroundMusic.stop()
