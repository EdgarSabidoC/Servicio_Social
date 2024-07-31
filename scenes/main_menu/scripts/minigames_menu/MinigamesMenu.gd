extends VBoxContainer

@onready var menu_textbox: MarginContainer = $MarginContainer/MenuTextbox
@onready var fractions_minigame: Button = $FractionsMinigame


func _ready() -> void:
	menu_textbox.print_message(menu_textbox.default_text, "c")


func _on_visibility_changed() -> void:
	if PlayerSession.is_practice_mode():
		# Si es modo práctica, se oculta el botón del minijuego de fracciones:
		self.fractions_minigame.hide()
