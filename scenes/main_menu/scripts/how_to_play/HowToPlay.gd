extends TabContainer

@onready var tab_bar_has_focus: bool = false
@onready var fractions_minigame: TabBar = $FractionsMinigame
@onready var additions_minigame: TabBar = $AdditionsMinigame
@onready var coordinates_minigame: TabBar = $CoordinatesMinigame
@onready var symmetry_minigame: TabBar = $SymmetryMinigame


# La señal se emite cuando un TabBar tiene el focus.
signal tab_bar_has_focus_sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_tab_title(0, "Fracciones")
	self.set_tab_title(1, "Sumas")
	self.set_tab_title(2, "Coordenadas")
	self.set_tab_title(3, "Simetría")
	self.set_tab_title(4, "Personajes")


func _process(_delta: float) -> void:
	if get_viewport().gui_get_focus_owner() is TabBar:
		if not self.tab_bar_has_focus:
			self.tab_bar_has_focus_sound.emit()
			self.tab_bar_has_focus = true
			return
	else:
		self.tab_bar_has_focus = false


# Reproduce un sonido cuando el TabBar tiene el focus:
func _on_tab_bar_focus() -> void:
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS, 10)


func _on_fractions_minigame_visibility_changed() -> void:
	if self.fractions_minigame and self.fractions_minigame.is_visible_in_tree():
		self._on_tab_bar_focus()


func _on_additions_minigame_visibility_changed() -> void:
	if self.additions_minigame and self.additions_minigame.is_visible_in_tree():
		self._on_tab_bar_focus()


func _on_coordinates_minigame_visibility_changed() -> void:
	if self.coordinates_minigame and self.coordinates_minigame.is_visible_in_tree():
		self._on_tab_bar_focus()


func _on_symmetry_minigame_visibility_changed() -> void:
	if self.symmetry_minigame and self.symmetry_minigame.is_visible_in_tree():
		self._on_tab_bar_focus()
