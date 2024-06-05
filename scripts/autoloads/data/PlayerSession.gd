extends Node

@onready var username: String = "Player"
@onready var score: float = 0
@onready var multipliers: Array[float]
@export var difficulty: String = "easy"


func clear_player() -> void:
	self.username = ""
	self.score = 0
	self.difficulty = "easy"
