extends CanvasLayer

@onready var main_menu: VBoxContainer = %MainMenu
@onready var play_btn: Button = $MenuContainer/MainMenu/PlayBtn
@onready var menu_background_color: ColorRect = $MenuBackgroundColor
@onready var menu_textbox: VBoxContainer = %MenuTextbox
@onready var exit_menu: Control = $ExitMenu
@onready var settings: TabContainer = %Settings
@onready var difficulty_menu: VBoxContainer = %DifficultyMenu
@onready var minigames_menu: VBoxContainer = %MinigamesMenu
@onready var how_to_play: TabContainer = %HowToPlay


func _ready() -> void:
	# Al iniciar se enfoca el botón Play:
	if !Mouse.mouse_mode_activated:
		play_btn.grab_focus()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if !main_menu.is_visible_in_tree():
			exit_menu.show()
		else:
			return
		if !Mouse.mouse_mode_activated:
			self.exit_menu.yes_btn.grab_focus()


func _on_exit_menu_yes_pressed() -> void:
	menu_background_color.fade_in() # Realiza un fade in al fondo del menú
	main_menu.show() # Se muestra el menú principal
	menu_textbox.show() # Se muestra el textbox del menú principal
	exit_menu.hide()
	if !Mouse.mouse_mode_activated:
		play_btn.grab_focus() # Se enfoca el botón play
	
	if settings.is_visible_in_tree():
			settings.hide()
	elif difficulty_menu.is_visible_in_tree():
		difficulty_menu.hide()
	elif minigames_menu.is_visible_in_tree():
		minigames_menu.hide()
	elif how_to_play.is_visible_in_tree():
		how_to_play.hide()
	else:
		return


func _on_exit_menu_no_pressed() -> void:
	self.exit_menu.hide()

