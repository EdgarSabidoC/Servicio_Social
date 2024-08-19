extends Resource
class_name CharacterResource

var name: String
var about: String
var problem: String
var bonus_multiplier: int
var defeated: bool
var rejected: bool
var intro_text: String
var outro_text: String
var correct_answer: Dictionary
var wrong_answers: Array[Dictionary]
var main_asset_path: String
var secondary_assets_paths: Array[String]


# Función que limpia los datos del personaje:
func clear() -> void:
	self.defeated = false
	self.rejected = false
	self.correct_answer = {}
	self.wrong_answers = []
	self.intro_text = ""
	self.outro_text = ""
	self.problem = ""


func is_rejected() -> bool:
	return self.rejected
