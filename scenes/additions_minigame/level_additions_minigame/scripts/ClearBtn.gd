extends Button

@onready var accept_btn: Button = $"../AcceptBtn"
@onready var total_label: Label = $"../../TicketTexture/TotalLabel"
@onready var ticket_texture: TextureRect = $"../../TicketTexture"


func _on_pressed() -> void:
	ticket_texture.hide()
	accept_btn.change_active_state()
