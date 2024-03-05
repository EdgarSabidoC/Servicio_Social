extends Button
@onready var main_menu: VBoxContainer = %MainMenu
@onready var settings: TabContainer = %Settings


# Oculta el menú de opciones y muestra el menú principal:
func _on_pressed() -> void:
	main_menu.show()
	settings.hide()
