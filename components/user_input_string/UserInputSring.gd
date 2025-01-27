extends LineEdit
class_name UserInputString 


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		Sfx.play_sound(Sfx.Sounds.KEY_PRESS)


# Guarda el nombre de usuario ingresado en la variable user_name:
func save_user_name() -> void:
	match text.length():
		1:
			text += "......"
		2:
			text += "....."
		3:
			text += "...."
		4:
			text += "..."
		5:
			text += ".."
		6:
			text += "."
		_:
			text = text.substr(0, 6)
	PlayerSession.name = text.to_upper()
	self.editable = false # Desactiva la entrada 


# Gener un nombre de usuario predeterminado
func default_user_name() -> void:
	PlayerSession.name = "JUGADOR"
	self.editable = false # Desactiva la entrada 


# Limpia la variable user_name:
func clear_name() -> void:
	PlayerSession.name = ""

