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
@onready var back_button: BackButton = $BackButton


func _ready() -> void:
	# Al iniciar se enfoca el botón Play:
	if !Mouse.mouse_mode_activated:
		self.play_btn.grab_focus()
	self.back_button.hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if !self.main_menu.is_visible_in_tree():
			self.exit_menu.show()
		else:
			return
		if !Mouse.mouse_mode_activated:
			self.exit_menu.yes_btn.grab_focus()


func _on_exit_menu_yes_pressed() -> void:
	self.menu_background_color.fade_in() # Realiza un fade in al fondo del menú
	self.main_menu.show() # Se muestra el menú principal
	self.menu_textbox.show() # Se muestra el textbox del menú principal
	self.exit_menu.hide()
	if !Mouse.mouse_mode_activated:
		self.play_btn.grab_focus() # Se enfoca el botón play
	
	if self.settings.is_visible_in_tree():
			self.settings.hide()
	elif self.difficulty_menu.is_visible_in_tree():
		self.difficulty_menu.hide()
	elif self.minigames_menu.is_visible_in_tree():
		self.minigames_menu.hide()
	elif self.how_to_play.is_visible_in_tree():
		self.how_to_play.hide()
	else:
		return


func _on_exit_menu_no_pressed() -> void:
	self.exit_menu.hide()
