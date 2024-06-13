extends TabBar

@onready var actual_tab: int = 0
@onready var actual_icon: Texture2D
@onready var v_box_container: VBoxContainer = $VBoxContainer
#@onready var label: Label = $VBoxContainer/Label
@onready var pressed_tab: bool = false
@onready var rich_text_label: RichTextLabel = $VBoxContainer/RichTextLabel


signal pressed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	v_box_container.hide()
	var character: CharacterResource
	var char_icon: Texture2D
	for tab in tab_count:
		character = CharactersData.characters[tab]
		char_icon = CharactersData.get_character_icon(character)
		set_tab_icon(tab, char_icon)


func _process(_delta: float) -> void:
	if is_visible_in_tree() and Input.is_action_just_pressed("ui_accept"):
		pressed.emit()


func _on_tab_selected(tab: int) -> void:
	actual_tab = tab


func _on_tab_clicked(_tab: int) -> void:
	# Test debug:
	print_debug("Tab clicked %s" % _tab)
	pressed_tab = !pressed_tab
	if pressed_tab:
		_hide_tabs()
		_get_character_info()
		v_box_container.show()
	else:
		_show_hidden_tabs()
		v_box_container.hide()


func _on_pressed() -> void:
	# Test debug:
	print_debug("Tab pressed %s" % actual_tab)
	pressed_tab = !pressed_tab
	if pressed_tab:
		_hide_tabs()
		_get_character_info()
		v_box_container.show()
	else:
		_show_hidden_tabs()
		v_box_container.hide()
	


# Oculta todas las tabs menos la actual_tab:
func _hide_tabs():
	for tab in tab_count:
		if actual_tab != tab:
			set_tab_hidden(tab, true)


# Muestra todas las tabs ocultas:
func _show_hidden_tabs():
	for tab in tab_count:
		if is_tab_hidden(tab):
			set_tab_hidden(tab, false)


# Obtiene la información de los personajes y la despliega en las etiquetas:
func _get_character_info() -> void:
	var char_name: String = CharactersData.characters[actual_tab].name
	var char_multiplier: float = CharactersData.characters[actual_tab].bonus_multiplier
	rich_text_label.text = "[center]Nombre: %s\n\nMultiplicador: %s[/center]" % [char_name, char_multiplier]


func _on_visibility_changed() -> void:
	if !is_visible_in_tree():
		if pressed_tab:
			_show_hidden_tabs()
			v_box_container.hide()
	else:
		if !Mouse.mouse_mode_activated:
			pass
