extends Button

@onready var accept_btn: Button = $"../AcceptBtn"
@onready var ticket_texture: TextureRect = $"../../TicketTexture"
@onready var total_label: Label = $"../../TotalLabel"

func _ready() -> void:
	# Se deshabilita:
	self.change_active_state()


# Cambia el estado activo del botón aceptar:
func change_active_state(): 
	self.disabled = !self.disabled
