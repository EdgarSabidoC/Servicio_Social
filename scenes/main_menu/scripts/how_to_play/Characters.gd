extends TabBar

@onready var actual_tab: int = 0
@onready var actual_icon: Texture2D
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var pressed_tab: bool = false
@onready var rich_text_label: RichTextLabel = $VBoxContainer/RichTextLabel
@onready var characters = CharactersData.characters.duplicate(true)


signal pressed


func _enter_tree() -> void:
	if !Mouse.mouse_mode_activated:
		self.mouse_filter = MOUSE_FILTER_IGNORE
		self.mouse_force_pass_scroll_events = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.v_box_container.hide()
	# Se configuran las tabs con los íconos e información del personaje:
	self.set_characters()


func _process(_delta: float) -> void:
	if is_visible_in_tree() and Input.is_action_just_pressed("ui_accept"):
		self.pressed.emit()


func _on_tab_selected(tab: int) -> void:
	self.actual_tab = tab


func _on_tab_clicked(_tab: int) -> void:
	self.pressed_tab = !self.pressed_tab
	if self.pressed_tab:
		self._hide_tabs()
		self._get_character_info()
		self.v_box_container.show()
	else:
		self._show_hidden_tabs()
		self.v_box_container.hide()


func _on_pressed() -> void:
	self.pressed_tab = !self.pressed_tab
	if self.pressed_tab:
		self._hide_tabs()
		self._get_character_info()
		self.v_box_container.show()
	else:
		self._show_hidden_tabs()
		self.v_box_container.hide()
	


# Oculta todas las tabs menos la actual_tab:
func _hide_tabs():
	for tab in self.tab_count:
		if self.actual_tab != tab:
			self.set_tab_hidden(tab, true)


# Muestra todas las tabs ocultas:
func _show_hidden_tabs():
	for tab in self.tab_count:
		if self.is_tab_hidden(tab):
			self.set_tab_hidden(tab, false)


# Obtiene la información de los personajes y la despliega en las etiquetas:
func _get_character_info() -> void:
	var char_name: String = self.characters[self.actual_tab].name
	var char_multiplier: float = self.characters[self.actual_tab].bonus_multiplier
	self.rich_text_label.text = "[center]Nombre: %s\n\nMultiplicador: %s[/center]" % [char_name, char_multiplier]


func _on_visibility_changed() -> void:
	if !self.is_visible_in_tree():
		if self.pressed_tab:
			self._show_hidden_tabs()
			self.v_box_container.hide()
	else:
		self.set_characters()


func _on_tab_hovered(_tab: int) -> void:
	if !Mouse.mouse_mode_activated:
		# Para evitar que el mouse capturado muestre el tema hovered:
		self.add_theme_stylebox_override("tab_hovered", self.get_theme_stylebox("tab_unselected"))


# Configura las tabs con los datos de los personajes:
func set_characters() -> void:
	# Se mezclan los personajes:
	randomize()
	self.characters.shuffle()
	var character: CharacterResource
	var char_icon: Texture2D
	for tab in self.tab_count:
		character = self.characters[tab]
		char_icon = CharactersData.get_character_icon(character)
		# Se añaden los íconos a las tabs:
		self.set_tab_icon(tab, char_icon)
