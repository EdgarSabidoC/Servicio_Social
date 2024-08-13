extends TabContainer

@onready var video: TabBar = $Video
@onready var controls: TabBar = $Controls
@onready var license: TabBar = $License


func _ready() -> void:
	self.set_tab_title(0, "Vídeo")
	self.set_tab_title(1, "Audio")
	self.set_tab_title(2, "Controles")
	self.set_tab_title(3, "Licencia")


# Para cambiar el fondo del TabContainer se tiene que agregar un nuevo StyleboxTexture
# en Theme Overrides -> Styles -> Panel -> new StyleboxTexture
# Luego editar el SytleboxTexture y agregar la textura.
# Es similar para las tablas


func _on_video_visibility_changed() -> void:
	if self.video.is_visible_in_tree():
		Sfx.play_sound(Sfx.Sounds.KEY_PRESS)


func _on_controls_visibility_changed() -> void:
	if self.controls.is_visible_in_tree():
		Sfx.play_sound(Sfx.Sounds.KEY_PRESS)


func _on_license_visibility_changed() -> void:
	if self.license.is_visible_in_tree():
		Sfx.play_sound(Sfx.Sounds.KEY_PRESS)
