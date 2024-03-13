extends Button

var hint: String = "Cerrar el juego." 


# Sale del juego/escena:
func _on_pressed() -> void:
	get_tree().quit()
