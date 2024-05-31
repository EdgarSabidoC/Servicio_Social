extends Node

@onready var username: String = "Player"
@onready var score: float = 0


func clear_player() -> void:
	self.username = ""
	self.score = 0
