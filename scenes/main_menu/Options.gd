extends Button
@onready var settings: TabContainer = %Settings


# Muestra el menú de las opciones de configuración y oculta el menú principal:
func _on_pressed() -> void:
	settings.show()
	get_parent().hide()
