extends Button

class_name AnswerButton


# Utilizar custom resources para almacenar la respuesta y los assets del botón.
var defeated: bool = false
var asset_path: String
var asset: Texture2D


# Inicializa la instancia, funciona como constructor.
# Se le pasa un Diccionario de respuesta:
func construct(answer: Dictionary) -> void:
	# Aquí se deben de cargar los assets.
	self.asset_path = answer.imagePath
	
	# Carga el Texture2D desde asset_path
	asset = load_texture(asset_path)
	
	if asset:
		# Se utiliza la textura en el botón:
		self.icon = asset
		# Se centra la imagen:
		self.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER


# Función para cargar un Texture2D desde una ruta
func load_texture(path: String) -> Texture2D:
	var texture = ResourceLoader.load(path)
	if texture is Texture2D:
		return texture
	else:
		print_debug("Error: No se pudo cargar la textura desde la ruta proporcionada.")
		return null


# Si es una respuesta correcta, se aumenta el score global:
func _on_pressed() -> void:
	if defeated:
		PlayerSession.score += 10000
		CharactersData.characters[0].defeated = true
		print_debug(CharactersData.characters[0].defeated)
