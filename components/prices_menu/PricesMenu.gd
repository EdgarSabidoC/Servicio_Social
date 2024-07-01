extends Control

@onready var back_btn: Button = $BackBtn
@onready var back_btn_text_changed: bool = false
@onready var prices: Dictionary
@onready var prices_label: RichTextLabel = $PricesTexture/Prices


signal back_btn_pressed


func _ready() -> void:
	if !Mouse.mouse_mode_activated:
		self.back_btn.grab_focus()
	self.prices = self.prices_label.get_prices()
	self.back_btn.text = "Iniciar"
	self.back_btn.grab_focus()


func _on_back_btn_pressed() -> void:
	self.hide()
	back_btn_pressed.emit()


func _on_back_btn_visibility_changed() -> void:
	# Se cambia el texto del botón después de iniciar el juego:
	if self.back_btn and !self.back_btn_text_changed:
		self.back_btn.text = "Regresar"
		self.back_btn_text_changed = true
	
	if self.back_btn and self.is_visible_in_tree():
		self.back_btn.grab_focus()
