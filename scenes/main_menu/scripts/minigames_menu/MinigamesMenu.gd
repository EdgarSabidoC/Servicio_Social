extends VBoxContainer

@onready var menu_textbox: MarginContainer = $MarginContainer/MenuTextbox
@onready var fractions_minigame: Button = $FractionsMinigame
@onready var additions_minigame: Button = $AdditionsMinigame
@onready var margin_container: MarginContainer = $MarginContainer


func _ready() -> void:
	menu_textbox.print_message(menu_textbox.default_text, "c")


func _on_visibility_changed() -> void:
	if self.is_visible_in_tree():
		self.margin_container.show()
	if PlayerSession.is_practice_mode():
		# Si es modo práctica, se oculta el botón del minijuego de fracciones:
		self.fractions_minigame.hide()
		self.additions_minigame.grab_focus()
	elif !Mouse.mouse_mode_activated:
		self.fractions_minigame.show()
		self.fractions_minigame.grab_focus()
