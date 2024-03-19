extends Node2D
#@export var _move_to: PackedScene

func _ready() -> void:
	# se cambia el volumen de la música de fondo a 10
	MenuBackgroundMusic.volume_db = 10
	
