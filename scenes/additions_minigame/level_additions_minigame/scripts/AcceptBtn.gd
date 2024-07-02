extends Button

@onready var ticket_texture: TextureRect = $"../../TicketTexture"
@onready var ticket_animation_player: AnimationPlayer = $"../../TicketTexture/TicketAnimationPlayer"
@onready var is_active: bool = false
@onready var total_label: Label = $"../../TotalLabel"


func _on_pressed() -> void:
	if !self.is_active and self.total_label.text != "":
		self.ticket_texture.show()
		self.ticket_animation_player.play("default")
		self.change_active_state()


# Cambia el estado activo del botón aceptar:
func change_active_state(): 
	self.is_active = !self.is_active
