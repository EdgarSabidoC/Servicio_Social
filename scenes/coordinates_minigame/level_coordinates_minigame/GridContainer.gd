extends GridContainer

@onready var drag_texture: DragTexture = $"../DragTexture"
@onready var drop_slot: DropSlot = $DropSlot


func _on_drop_slot_texture_dropped(coordinates: Vector2i) -> void:
	if coordinates == drag_texture.coordinates:
		print_debug("Coordenadas iguales")
