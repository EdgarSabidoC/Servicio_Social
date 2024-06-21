extends AnimationPlayer

@onready var alux: AnimatedTextureRect = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if alux.is_visible_in_tree() and self.alux.current_animation == "entrance" and self.alux.frame_index == 30:
		#self.play("entrance")
		pass


func _on_alux_finished() -> void:
	if self.alux.current_animation == "entrance" and !self.alux.playing:
		self.alux.play("default")
	self.alux.changed = true
