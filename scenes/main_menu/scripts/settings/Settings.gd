extends TabContainer

@onready var video: TabBar = $Video
@onready var controls: TabBar = $Controls
@onready var license: TabBar = $License
@onready var audio: TabBar = $Audio
@onready var tab_bar_has_focus: bool = false


# La señal se emite cuando un TabBar tiene el focus.
signal tab_bar_has_focus_sound


func _ready() -> void:
	self.set_tab_title(0, "Vídeo")
	self.set_tab_title(1, "Audio")
	self.set_tab_title(2, "Controles")
	self.set_tab_title(3, "Licencia")
	self.tab_bar_has_focus_sound.connect(_on_tab_bar_focus)


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


# Para cambiar el fondo del TabContainer se tiene que agregar un nuevo StyleboxTexture
# en Theme Overrides -> Styles -> Panel -> new StyleboxTexture
# Luego editar el SytleboxTexture y agregar la textura.
# Es similar para las tablas


func _on_video_visibility_changed() -> void:
	if self.video.is_visible_in_tree():
		self._on_tab_bar_focus()


func _on_controls_visibility_changed() -> void:
	if self.controls.is_visible_in_tree():
		self._on_tab_bar_focus()


func _on_license_visibility_changed() -> void:
	if self.license.is_visible_in_tree():
		self._on_tab_bar_focus()

