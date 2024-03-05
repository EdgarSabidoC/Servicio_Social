extends TabContainer
@onready var video = $Video

#var textureTab0: Texture2D = load("res://icon.svg")
#var textureTab1: Texture2D
#var textureTab2: Texture2D

func _ready() -> void:
	set_tab_title(0, "Vídeo")
	#set_tab_icon(0, textureTab0)
	set_tab_title(1, "Audio")
	set_tab_title(2, "Controles")
