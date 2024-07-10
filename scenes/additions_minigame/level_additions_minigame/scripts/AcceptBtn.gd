extends Button

@onready var ticket_texture: TextureRect = $"../../TicketTexture"
@onready var ticket_animation_player: AnimationPlayer = $"../../TicketTexture/TicketAnimationPlayer"
@onready var total_label: Label = $"../../TotalLabel"


# Cambia el estado activo del botón aceptar:
func change_active_state(): 
	self.disabled = !self.disabled
