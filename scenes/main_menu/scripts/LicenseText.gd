extends RichTextLabel


func _ready() -> void:
	# Se carga la información desde el archivo:
	self.text =  "[center]%s[/center]" % _load()

# Carga el archivo de licensia de Godot:
func _load() -> String:
	var file: FileAccess = FileAccess.open("res://assets/graphical_assets/texts/license/godot_license.txt", FileAccess.READ)
	var content: String = file.get_as_text()
	return content
