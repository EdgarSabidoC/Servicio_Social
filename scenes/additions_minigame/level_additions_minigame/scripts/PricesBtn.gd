extends Button

@onready var prices_menu: Control = $"../PricesMenu"



func _on_pressed() -> void:
	prices_menu.show()
