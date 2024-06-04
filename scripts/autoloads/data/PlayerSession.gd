extends Node

@onready var username: String = "Player"
@onready var score: float = 0
@onready var multipliers: Array[float]


func clear_player() -> void:
	self.username = ""
	self.score = 0
