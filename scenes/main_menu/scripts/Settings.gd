extends TabContainer
@onready var video = $Video
@onready var menu_background = %MenuBackground

#var textureTab0: Texture2D = load("res://icon.svg")
#var textureTab1: Texture2D
#var textureTab2: Texture2D

func _ready() -> void:
	self.set_tab_title(0, "Vídeo")
	self.set_tab_title(1, "Audio")
	self.set_tab_title(2, "Controles")
	self.set_tab_title(3, "Licencia")

# Para cambiar el fondo del TabContainer se tiene que agregar un nuevo StyleboxTexture
# en Theme Overrides -> Styles -> Panel -> new StyleboxTexture
# Luego editar el SytleboxTexture y agregar la textura.
# Es similar para las tablas
