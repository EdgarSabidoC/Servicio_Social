extends Button

@export var hint: String = "Comienza a jugar."
@export var seconds_to_wait = 3
@onready var difficulty_menu = %DifficultyMenu
@onready var text_box_container: Control = %MenuTextbox
@onready var menu_background_color = $"../../../MenuBackgroundColor"
@onready var settings_background_color = $"../../../SettingsBackgroundColor"


func _ready() -> void:
	grab_focus()


func _on_pressed() -> void:
	# Moverse al menú de selección de dificultad:
	settings_background_color.show()
	menu_background_color.fade_out()
	difficulty_menu.show()
	get_parent().hide() # Oculta el menú principal
	text_box_container.hide() # Oculta el textbox del menú principal
