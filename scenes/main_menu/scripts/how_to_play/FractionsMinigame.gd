extends TabBar

@onready var up: ActionIcon = ActionIcon.new()
@onready var down: ActionIcon = ActionIcon.new()
@onready var left: ActionIcon = ActionIcon.new()
@onready var right: ActionIcon = ActionIcon.new()
@onready var m1: ActionIcon = ActionIcon.new()
@export var up_width: float = 0
@export var up_height: float = 80
@export var down_width: float = 0
@export var down_height: float = 80
@export var left_width: float = 0
@export var left_height: float = 80
@export var right_width: float = 0
@export var right_height: float = 80
@export var m1_width: float = 0
@export var m1_height: float = 60


func _ready() -> void:
	# Se asginan las acciones a los ActionIcon:
	up.action_name = "ui_up"
	down.action_name = "ui_down"
	left.action_name = "ui_left"
	right.action_name = "ui_right"
	m1.action_name = "m1"
	
	# Se carga la información desde el archivo:
	#var text: String =  "[center]%s[/center]" % _load_data()
	var text: String = "Las teclas de navegación son: "
	$ScrollbarTextbox.print_text(text)


# Carga el archivo de licensia de Godot:
func _load_data() -> String:
	var file: FileAccess = FileAccess.open("res://assets/graphical_assets/texts/how_to_play/fractions_minigame.txt", FileAccess.READ)
	if not file:
		return ""
	var content: String = file.get_as_text()
	return content
