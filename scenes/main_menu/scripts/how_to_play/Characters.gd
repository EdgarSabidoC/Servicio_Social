extends TabBar

@onready var actual_tab: int = 0
@onready var actual_icon: Texture2D
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var pressed_tab: bool = false
@onready var rich_text_label: RichTextLabel = $VBoxContainer/RichTextLabel


signal pressed


func _enter_tree() -> void:
	if !Mouse.mouse_mode_activated:
		self.mouse_filter = MOUSE_FILTER_IGNORE
		self.mouse_force_pass_scroll_events = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	v_box_container.hide()
	var character: CharacterResource
	var char_icon: Texture2D
	for tab in tab_count:
		character = CharactersData.characters[tab]
		char_icon = CharactersData.get_character_icon(character)
		# Se añaden los íconos a las tabs:
		self.set_tab_icon(tab, char_icon)


func _process(_delta: float) -> void:
	if is_visible_in_tree() and Input.is_action_just_pressed("ui_accept"):
		self.pressed.emit()


func _on_tab_selected(tab: int) -> void:
	self.actual_tab = tab


func _on_tab_clicked(_tab: int) -> void:
	# Test debug:
	print_debug("Tab clicked %s" % _tab)
	self.pressed_tab = !self.pressed_tab
	if self.pressed_tab:
		_hide_tabs()
		_get_character_info()
		v_box_container.show()
	else:
		_show_hidden_tabs()
		v_box_container.hide()


func _on_pressed() -> void:
	# Test debug:
	print_debug("Tab pressed %s" % actual_tab)
	self.pressed_tab = !self.pressed_tab
	if self.pressed_tab:
		_hide_tabs()
		_get_character_info()
		v_box_container.show()
	else:
		_show_hidden_tabs()
		v_box_container.hide()
	


# Oculta todas las tabs menos la actual_tab:
func _hide_tabs():
	for tab in self.tab_count:
		if self.actual_tab != tab:
			set_tab_hidden(tab, true)


# Muestra todas las tabs ocultas:
func _show_hidden_tabs():
	for tab in tab_count:
		if self.is_tab_hidden(tab):
			self.set_tab_hidden(tab, false)


# Obtiene la información de los personajes y la despliega en las etiquetas:
func _get_character_info() -> void:
	var char_name: String = CharactersData.characters[actual_tab].name
	var char_multiplier: float = CharactersData.characters[actual_tab].bonus_multiplier
	rich_text_label.text = "[center]Nombre: %s\n\nMultiplicador: %s[/center]" % [char_name, char_multiplier]


func _on_visibility_changed() -> void:
	if !is_visible_in_tree():
		if self.pressed_tab:
			_show_hidden_tabs()
			v_box_container.hide()


func _on_tab_hovered(_tab: int) -> void:
	if !Mouse.mouse_mode_activated:
		# Para evitar que el mouse capturado muestre el tema hovered:
		self.add_theme_stylebox_override("tab_hovered", self.get_theme_stylebox("tab_unselected"))
