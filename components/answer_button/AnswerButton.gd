class_name AnswerButton extends Button

# Utilizar custom resources para almacenar la respuesta y los assets del botón.
var answerFlag: bool = false
var normalAsset: Texture2D
var hoverAsset: Texture2D

# Inicializa la instancia, funciona como constructor:
func _init(answerFlag, normalAsset, hoverAsset) -> void: 
	# Aquí se deben de cargar los assets.
	self.answerFlag = answerFlag
	self.normalAsset = normalAsset
	self.hoverAsset = hoverAsset
