extends TabContainer


func _ready() -> void:
	self.set_tab_title(0, "Vídeo")
	self.set_tab_title(1, "Audio")
	self.set_tab_title(2, "Controles")
	self.set_tab_title(3, "Licencia")


# Para cambiar el fondo del TabContainer se tiene que agregar un nuevo StyleboxTexture
# en Theme Overrides -> Styles -> Panel -> new StyleboxTexture
# Luego editar el SytleboxTexture y agregar la textura.
# Es similar para las tablas
