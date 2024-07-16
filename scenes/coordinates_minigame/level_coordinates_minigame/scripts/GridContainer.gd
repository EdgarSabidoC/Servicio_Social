extends GridContainer

@onready var drag_and_droptexture: DragAndDropTexture = $"../DragAndDropTexture"


func _on_drop_slot_texture_dropped(coordinates: Vector2i) -> void:
	if coordinates == drag_and_droptexture.coordinates:
		print_debug("Coordenadas iguales")
