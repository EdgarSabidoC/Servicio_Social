extends AnimationPlayer

@onready var zotz: AnimatedTextureRect = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if self.zotz.current_animation == "entrance" and self.zotz.frame_index == 30:
		self.play("entrance")


func _on_zotz_finished() -> void:
	if self.zotz.current_animation == "entrance" and !self.zotz.playing:
		self.zotz.play("default")
