extends Button

#var _move_to: PackedScene
@export var hint: String = "Comienza a jugar."

func _ready() -> void:
	grab_focus()


func _on_pressed() -> void:
	MenuBackgroundMusic.stop()
