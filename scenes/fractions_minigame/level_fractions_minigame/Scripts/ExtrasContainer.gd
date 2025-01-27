extends VBoxContainer

@onready var drinks = $Drinks
@onready var breads = $Breads
@onready var extras_container: VBoxContainer = $"."
@onready var postick_0_1: TextureRect = $"../../Postick_0_1"
@onready var postick_0_2: TextureRect = $"../../Postick_0_2"
@onready var postick_5: TextureRect = $"../../Postick_5"
@onready var postick_10: TextureRect = $"../../Postick_10"
@onready var soda: TextureRect = $"../../Soda"
@onready var bread: TextureRect = $"../../Bread"


func _ready() -> void:
	if PlayerSession.difficulty == "easy":
		self.hide()
		postick_0_1.hide()
		postick_0_2.hide()
		postick_5.hide()
		postick_10.hide()
		soda.hide()
		bread.hide()
