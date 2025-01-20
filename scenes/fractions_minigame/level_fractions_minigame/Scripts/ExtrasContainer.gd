extends VBoxContainer

@onready var drinks = $Drinks
@onready var breads = $Breads
@onready var extras_container: VBoxContainer = $"."


func _ready() -> void:
	if PlayerSession.difficulty == "easy":
		self.hide()
