extends Button
@onready var settings: TabContainer = %Settings
@onready var video = $"../../Settings/Video"

# Muestra el menú de las opciones de configuración y oculta el menú principal:
func _on_pressed() -> void:
	settings.show() # Muestra el menú de opciones
	settings.get_tab_bar().grab_focus() # Enfoca la TabBar de Vídeo
	get_parent().hide() # Oculta el menú principal
