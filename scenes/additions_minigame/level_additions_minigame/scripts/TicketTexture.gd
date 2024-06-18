extends TextureRect

@onready var total_label: Label = $TotalLabel
@onready var total_number_label: Label = $"../TotalNumberLabel"
@onready var total_animation_player: AnimationPlayer = $TotalLabel/TotalAnimationPlayer
@onready var ticket_animation_player: AnimationPlayer = $TicketAnimationPlayer


func _ready() -> void:
	pass


func _on_visibility_changed() -> void:
	if !self.is_visible_in_tree():
		ticket_animation_player.play("RESET")
		total_animation_player.play("RESET")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	print_debug("Finalizó la animación del ticket")


func _on_animation_player_animation_started(_anim_name: StringName) -> void:
	total_animation_player.play("default")
