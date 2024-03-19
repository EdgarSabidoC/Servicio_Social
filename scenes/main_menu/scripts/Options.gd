extends Button
@onready var settings: TabContainer = %Settings
@onready var video = $"../../../Settings/Video"
@onready var text_box_container: VBoxContainer = %MenuTextbox
@onready var menu_background = %MenuBackground
@onready var settings_background_color = $"../../../SettingsBackgroundColor"
@onready var menu_background_color = $"../../../MenuBackgroundColor"
@export var hint: String = "Abre el menú de opciones de configuración:\n⚙️ Vídeo\n⚙️ Audio\n⚙️ Controles"


# Muestra el menú de las opciones de configuración y oculta el menú principal:
func _on_pressed() -> void:
	settings_background_color.show()
	menu_background_color.fade_out()
	settings.show() # Muestra el menú de opciones
	settings.get_tab_bar().grab_focus() # Enfoca la TabBar de Video
	get_parent().hide() # Oculta el menú principal
	text_box_container.hide() # Oculta el textbox del menú principal
