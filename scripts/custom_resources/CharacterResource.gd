extends Resource
class_name CharacterResource

var name: String
var problem: String
var bonus_multiplier: float
var defeated: bool
var intro_text: String
var outro_text: String
var correct_asnwer: Dictionary
var wrong_asnwers: Array[Dictionary]
var main_asset_path: String
var secondary_assets_paths: Array[String]


# Función que limpia los datos del personaje:
func clear_character_data() -> void:
	self.problem = ""
	self.defeated = false
	self.intro_text = ""
	self.outro_text = ""
	self.correct_asnwer = {}
	self.wrong_asnwers = []
