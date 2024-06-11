extends Node

@onready var username: String = "Player"
@onready var score: float = 0
@onready var multipliers: Array[float]
@export var difficulty: String = "easy"
@export var character: int = 0
@onready var secret_level: bool = false


# Limpia las variables de la sesión del juego:
func clear_player_session() -> void:
	self.username = ""
	self.score = 0
	self.difficulty = "easy"
	self.multipliers = []
	self.character = 0
	self.secret_level = false


# Obtiene el siguiente personaje:
func next_character() -> void:
	self.character += 1
