extends Control

@onready var label_1: Label = $VBoxContainer/Label1
@export var _move_to: PackedScene
@onready var keyboard_mode: Button = $VBoxContainer/HBoxContainer/KeyboardMode
@onready var mouse_mode: Button = $VBoxContainer/HBoxContainer/MouseMode
@onready var rich_text_label_text_flash: RichTextLabelTextFlash = $VBoxContainer/RichTextLabelTextFlash
@onready var keyboard_mode_texture_path: String = "res://addons/ActionIcon/Keyboard/WSAD.png"
@onready var mouse_mode_texture_path: String = "res://addons/ActionIcon/Mouse/None.png"


func _ready() -> void:
	assert(_move_to)
	mouse_mode.grab_focus()
	keyboard_mode.icon =  ResourceLoader.load(keyboard_mode_texture_path)
	mouse_mode.icon =  ResourceLoader.load(mouse_mode_texture_path)


# Activa el modo teclado:
func _on_keyboard_mode_pressed():
	Sfx.play_sound(Sfx.Sounds.SCREEN_PRESS, 10)
	if Mouse.mouse_mode_activated:
		Mouse.change_mode()
	# Comienza la animación de desvanecimiento y cambia de escena al final de la animación:
	SceneTransition.change_scene(_move_to, "dissolve")


# Activa el modo ratón:
func _on_mouse_mode_pressed():
	Sfx.play_sound(Sfx.Sounds.SCREEN_PRESS)
	if !Mouse.mouse_mode_activated:
		Mouse.change_mode()
	# Comienza la animación de desvanecimiento y cambia de escena al final de la animación:
	SceneTransition.change_scene(_move_to, "dissolve")


func _on_mouse_mode_focus_entered() -> void:
	self.mouse_mode.grab_focus()
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS, 10)


func _on_mouse_mode_mouse_entered() -> void:
	self.mouse_mode.grab_focus()
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS, 10)


func _on_keyboard_mode_mouse_entered() -> void:
	self.keyboard_mode.grab_focus()
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS, 10)


func _on_keyboard_mode_focus_entered() -> void:
	self.keyboard_mode.grab_focus()
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS, 10)
