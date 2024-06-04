extends Timer

@onready var seconds: float = 0
@onready var minutes: float = 0


func _ready() -> void:
	$Timer.start()



func _process(delta: float) -> void:
	pass
