extends Button

@onready var accept_btn: Button = $"../AcceptBtn"
@onready var ticket_texture: TextureRect = $"../../TicketTexture"
@onready var total_label: Label = $"../../TotalLabel"


func _on_pressed() -> void:
	self.ticket_texture.hide()
	if !self.accept_btn.active:
		self.accept_btn.change_active_state()
	self.total_label.text = ""
