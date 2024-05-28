extends Control
@onready var texture_rect = $TextureRect
@onready var menu_container = $"../MenuContainer"
@onready var menu_background_color = $"../MenuBackgroundColor"
@onready var label = $Label


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE) \
	|| Input.is_key_pressed(KEY_ENTER):
		await wait_to_hide(0.01)


# Función que espera para ocltar el componente:
func wait_to_hide(seconds: float) -> void:
	var musicPosition: float = MenuBackgroundMusic.get_playback_position()
	await get_tree().create_timer(seconds).timeout
	texture_rect.fade_out()
	self.hide()
	MenuBackgroundMusic.play(musicPosition)
