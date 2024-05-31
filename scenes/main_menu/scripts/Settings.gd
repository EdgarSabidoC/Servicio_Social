extends TabContainer

@onready var settings = %Settings
@onready var video = $Video
@onready var audio = $Audio
@onready var controls = $Controls
@onready var license = $License

#var textureTab0: Texture2D = load("res://icon.svg")
#var textureTab1: Texture2D
#var textureTab2: Texture2D

func _ready() -> void:
	self.set_tab_title(0, "Vídeo")
	self.set_tab_title(1, "Audio")
	self.set_tab_title(2, "Controles")
	self.set_tab_title(3, "Licencia")


# Función que permite regresar al menú principal si se presiona el botón de Pausa/Salir:
func _unhandled_key_input(_event: InputEvent) -> void:
	#if Input.is_action_pressed("ui_cancel"):
		#menu_background_color.fade_in() # Realiza un fade in al fondo del menú
		#settings.current_tab = 0 # Se selecciona la TabBar de Video
		#settings.get_current_tab_control().grab_focus() # Se enfoca la TabBar de Video
		#main_menu.show() # Se muestra el menú principal
		#text_box_container.show() # Se muestra el textbox del menú principal
		#play.grab_focus() # Se enfoca el botón play
		#settings.hide() # Se oculta el menú de opciones de configuración
	pass


# Para cambiar el fondo del TabContainer se tiene que agregar un nuevo StyleboxTexture
# en Theme Overrides -> Styles -> Panel -> new StyleboxTexture
# Luego editar el SytleboxTexture y agregar la textura.
# Es similar para las tablas
