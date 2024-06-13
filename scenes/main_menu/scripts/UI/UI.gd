extends CanvasLayer

@onready var main_menu: VBoxContainer = %MainMenu
@onready var play_btn: Button = $MenuContainer/MainMenu/PlayBtn
@onready var menu_background_color: ColorRect = $MenuBackgroundColor
@onready var menu_textbox: VBoxContainer = %MenuTextbox

@onready var settings: TabContainer = %Settings
@onready var difficulty_menu: VBoxContainer = %DifficultyMenu
@onready var minigames_menu: VBoxContainer = %MinigamesMenu


func _ready() -> void:
	# Al iniciar se enfoca el botón Play:
	if !Mouse.mouse_mode_activated:
		play_btn.grab_focus()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if settings.is_visible_in_tree():
			settings.hide()
		elif difficulty_menu.is_visible_in_tree():
			difficulty_menu.hide()
		elif minigames_menu.is_visible_in_tree():
			minigames_menu.hide()
		else:
			return
		menu_background_color.fade_in() # Realiza un fade in al fondo del menú
		main_menu.show() # Se muestra el menú principal
		menu_textbox.show() # Se muestra el textbox del menú principal
		if !Mouse.mouse_mode_activated:
			play_btn.grab_focus() # Se enfoca el botón play
		
		
