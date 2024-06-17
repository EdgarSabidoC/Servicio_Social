extends Button

@onready var total_label: Label = $"../../TicketTexture/TotalLabel"
@onready var total_animation_player: AnimationPlayer = $"../../TicketTexture/TotalLabel/TotalAnimationPlayer"
@onready var ticket_texture: TextureRect = $"../../TicketTexture"
@onready var ticket_animation_player: AnimationPlayer = $"../../TicketTexture/TicketAnimationPlayer"

@onready var active: bool = false

func _on_pressed() -> void:
	change_active_state()
	
	if self.active:
		ticket_texture.show()
		ticket_animation_player.play("default")


func change_active_state(): 
	self.active = !self.active
