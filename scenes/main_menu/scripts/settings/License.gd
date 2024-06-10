extends TabBar

@onready var scrollbar_textbox = $scrollbar_textbox
@onready var settings = %Settings
@onready var controls: TabBar = $"../Controls"


func _ready() -> void:
	# Se carga la información desde el archivo:
	var text: String =  "[center]%s[/center]" % _load_license()
	scrollbar_textbox.print_text(text)


# Carga el archivo de licensia de Godot:
func _load_license() -> String:
	var file: FileAccess = FileAccess.open("res://assets/graphical_assets/texts/license/godot_license.txt", FileAccess.READ)
	var content: String = file.get_as_text()
	return content

