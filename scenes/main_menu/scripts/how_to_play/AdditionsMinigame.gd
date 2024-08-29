extends TabBar


func _ready() -> void:
	# Se carga la información desde el archivo:
	var text: String =  "[center]%s[/center]" % _load_data()
	$ScrollbarTextbox.print_text(text)


# Carga el archivo de licensia de Godot:
func _load_data() -> String:
	var file: FileAccess = FileAccess.open("res://assets/graphical_assets/texts/how_to_play/additions_minigame.txt", FileAccess.READ)
	if not file:
		return ""
	var content: String = file.get_as_text()
	return content
