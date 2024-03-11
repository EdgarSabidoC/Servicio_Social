extends Control
@onready var main_menu: VBoxContainer = %MainMenu
@onready var settings: TabContainer = %Settings
@onready var play: Button = $"../../../MenuContainer/MainMenu/Play"
@onready var text_box_container: VBoxContainer = %MenuTextbox

# Oculta el menú de opciones y muestra el menú principal:
func _on_button_pressed() -> void:
	main_menu.show()
	text_box_container.show()
	play.grab_focus()
	settings.hide()
