extends LineEdit
class_name UserInputString 


# Guarda el nombre de usuario ingresado en la variable user_name:
func save_user_name() -> void:
	PlayerSession.name = text.to_upper()
	self.editable = false # Desactiva la entrada 


# Gener un nombre de usuario predeterminado
func default_user_name() -> void:
	PlayerSession.name = "JUGADOR"
	self.editable = false # Desactiva la entrada 


# Limpia la variable user_name:
func clear_name() -> void:
	PlayerSession.name = ""

