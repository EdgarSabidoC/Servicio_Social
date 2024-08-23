extends AnimationPlayer

@onready var huolpoch: AnimatedTextureRect = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.huolpoch.connect("finished", _on_huolpoch_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if huolpoch.is_visible_in_tree() and self.huolpoch.current_animation == "entrance" and self.huolpoch.frame_index == 30:
		self.play("entrance")


func _on_huolpoch_finished() -> void:
	if self.huolpoch.current_animation == "entrance" and !self.huolpoch.playing:
		self.huolpoch.play("default")
	self.huolpoch.changed = true
