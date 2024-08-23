extends AnimationPlayer

@onready var toh: AnimatedTextureRect = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.toh.connect("finished", _on_toh_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if toh.is_visible_in_tree() and self.toh.current_animation == "entrance" and self.toh.frame_index == 30:
		self.play("entrance")


func _on_toh_finished() -> void:
	if self.toh.current_animation == "entrance" and !self.huolpoch.playing:
		self.toh.play("default")
	self.toh.changed = true
