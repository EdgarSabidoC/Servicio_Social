extends Node

@onready var username: String = "Player"
@onready var score: int = 0
@onready var multipliers: Array[float]
@export var difficulty: String = "easy"
@export var character: int = 0
@onready var secret_level: bool = false
@onready var alux_rejected: bool = false


# Limpia las variables de la sesión del juego:
func clear_player_session() -> void:
	self.username = ""
	self.score = 0
	self.difficulty = "easy"
	self.multipliers = []
	self.character = 0
	self.secret_level = false


# Obtiene el siguiente personaje:
func next_character() -> int:
	return self.character + 1


# Función que guarda el puntaje del jugador entre los puntajes más altos:
func save_score() -> void:
	# Si el puntaje sobrepasa los 8 dígitos:
	if self.score > 99999999:
		self.score = 99999999
	Persistence.config.set_value("BestScores", "HighScores", self.score)
	Persistence.save_data()
