extends TextureRect

@onready var total_number_label: Label = $"../TotalNumberLabel"
@onready var ticket_animation_player: AnimationPlayer = $TicketAnimationPlayer
@onready var ticket_total_label: Label = $TicketTotalLabel
@onready var total_label: Label = $"../TotalLabel"


func _on_visibility_changed() -> void:
	if !self.is_visible_in_tree():
		ticket_animation_player.play("reset")
		ticket_total_label.text = "TOTAL:\n\n"


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "default":
		if self.total_label.text.ends_with("."):
			ticket_total_label.text += "$%s00" % total_label.text
		elif self.total_label.text.contains("."):
			ticket_total_label.text += "$%s" % total_label.text
		else:
			ticket_total_label.text += "$%s.00" % total_label.text


func _on_total_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "default":
		ticket_total_label.text = "Total:\n\n"
