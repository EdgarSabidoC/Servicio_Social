extends Button

@onready var accept_btn: Button = $"../AcceptBtn"
@onready var ticket_texture: TextureRect = $"../../TicketTexture"
@onready var total_label: Label = $"../../TotalLabel"


func _on_pressed() -> void:
	ticket_texture.hide()
	accept_btn.change_active_state()
	total_label.text = ""
