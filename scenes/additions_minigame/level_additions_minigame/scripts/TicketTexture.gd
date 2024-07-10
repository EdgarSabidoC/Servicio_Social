extends TextureRect

@onready var total_number_label: Label = $"../TotalNumberLabel"
@onready var ticket_animation_player: AnimationPlayer = $TicketAnimationPlayer
@onready var ticket_total_label: Label = $TicketTotalLabel
@onready var total_label: Label = $"../TotalLabel"
@onready var accept_btn: Button = $"../VBoxContainer/AcceptBtn"
@onready var clear_btn: Button = $"../VBoxContainer/ClearBtn"


func _on_visibility_changed() -> void:
	if !self.is_visible_in_tree():
		ticket_animation_player.play("reset")
		ticket_total_label.text = "TOTAL:\n\n"


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "default":
		# Se eliminan los ceros iniciales:
		self.remove_leading_zeros()
		
		if self.total_label.text.ends_with("."):
			ticket_total_label.text = "TOTAL:\n\n$%s00" % total_label.text
		elif self.total_label.text.contains("."):
			ticket_total_label.text = "TOTAL:\n\n$%s" % total_label.text
		else:
			ticket_total_label.text = "TOTAL:\n\n$%s.00" % total_label.text


# Elimina los ceros al inicio de la cadena:
func remove_leading_zeros() -> void:
	var regex = RegEx.new()
	regex.compile("^0+(?!\\.)")  # Coincide con cualquier cantidad de ceros al inicio de la cadena
	self.total_label.text = regex.sub(self.total_label.text, "", 1)  # Reemplaza la coincidencia con una cadena vacía
