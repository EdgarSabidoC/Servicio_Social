extends Node

@onready var username: String = "Jugador"
@onready var score: int = 0
@onready var multipliers: Array[float]
@export var difficulty: String = "easy"
@export var character: int = 0
enum Minigames {FRACCTIONS = 0, ADDITIONS = 1, COORDINATES = 2, SYMMETRY = 3}
@onready var current_minigame: Minigames
@onready var practice_mode: bool = false
@onready var fractions_info_screen: bool = false
@onready var additions_info_screen: bool = false
@onready var coordinates_info_screen: bool = false
@onready var symmetry_info_screen: bool = false
@onready var debug_mode: bool = false


# Limpia las variables de la sesión del juego:
func clear_player_session() -> void:
	self.username = ""
	self.score = 0
	self.difficulty = "easy"
	self.multipliers = []
	self.character = 0


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


# Función que cambia de estado la bandera de modo práctica:
func change_practice_mode() -> bool:
	if self.practice_mode:
		self.practice_mode = false
	else:
		self.practice_mode = true
	return self.practice_mode


func is_practice_mode() -> bool:
	return self.practice_mode


# Indica si se debe de destruir o mostrar la pantalla de información:
func destroy_info_screen() -> bool:
	return (fractions_info_screen and additions_info_screen \
			and coordinates_info_screen and symmetry_info_screen)
