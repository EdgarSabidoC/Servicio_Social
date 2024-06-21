extends AnimationPlayer

@onready var keken: AnimatedTextureRect = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.keken.connect("finished", _on_keken_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if self.keken.current_animation == "entrance" and self.keken.frame_index == 10:
		self.play("entrance")


func _on_keken_finished() -> void:
	if self.keken.current_animation == "entrance" and !self.keken.playing:
		self.keken.play("default")
	self.keken.changed = true
