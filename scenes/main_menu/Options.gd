extends Button
@onready var settings: TabContainer = %Settings
@onready var video = $"../../../Settings/Video"
@onready var text_box_container: VBoxContainer = %MenuTextbox

var hint: String = "Abre el menú de opciones de configuración:\n⚙️ Vídeo\n⚙️ Audio\n⚙️ Controles"

# Muestra el menú de las opciones de configuración y oculta el menú principal:
func _on_pressed() -> void:
	settings.show() # Muestra el menú de opciones
	settings.get_tab_bar().grab_focus() # Enfoca la TabBar de Vídeo
	get_parent().hide() # Oculta el menú principal
	text_box_container.hide()
