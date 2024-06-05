extends LineEdit
 
@onready var user_name: String


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ENTER) and self.text != "":
		save_user_name()
		self.editable = false
		set_process(false)


# Guarda el nombre de usuario ingresado en la variable user_name:
func save_user_name() -> void:
	self.user_name = text
	print_debug(user_name)

# Gener un nombre de usuario predeterminado
func default_user_name() -> void:
	self.user_name = "Jugador" 


# Limpia la variable user_name:
func clear_name() -> void:
	self.user_name = ""
