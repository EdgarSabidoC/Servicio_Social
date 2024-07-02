extends Button

@onready var accept_btn: Button = $"../AcceptBtn"
@onready var ticket_texture: TextureRect = $"../../TicketTexture"
@onready var total_label: Label = $"../../TotalLabel"


func _on_pressed() -> void:
	self.ticket_texture.hide()
	if !self.accept_btn.is_active:
		self.accept_btn.is_active = true
	self.total_label.text = ""
