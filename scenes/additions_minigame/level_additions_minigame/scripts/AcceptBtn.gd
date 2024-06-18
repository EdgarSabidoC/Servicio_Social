extends Button

@onready var ticket_texture: TextureRect = $"../../TicketTexture"
@onready var ticket_animation_player: AnimationPlayer = $"../../TicketTexture/TicketAnimationPlayer"
@onready var active: bool = true
@onready var total_label: Label = $"../../TotalLabel"


func _on_pressed() -> void:
	
	if self.active and self.total_label.text != "":
		self.change_active_state()
		self.ticket_texture.show()
		self.ticket_animation_player.play("default")


func change_active_state(): 
	self.active = !self.active
