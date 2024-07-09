extends GridContainer

@onready var drag_texture: DragTexture = $"../DragTexture"



func _on_drop_slot_texture_dropped(coordinates: Vector2i) -> void:
	if coordinates == drag_texture.coordinates:
		print_debug("Coordenadas iguales")
