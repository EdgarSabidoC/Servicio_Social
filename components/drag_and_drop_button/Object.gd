extends Sprite2D

var dragging: bool = false
var of = Vector2(0,0)
#var snap = 128
@onready var button: Button = $Button


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if self.dragging:
		self.position = self.get_global_mouse_position() - self.of
		#var new_position = self.get_global_mouse_position() - self.of
		#self.position = Vector2(snapped(new_position.x, snap), snapped(new_position.y, snap)) 


func _on_button_button_down() -> void:
	self.dragging = true
	self.of = self.get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	self.dragging = false
