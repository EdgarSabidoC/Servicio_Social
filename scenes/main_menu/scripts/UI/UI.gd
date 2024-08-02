extends CanvasLayer

@onready var main_menu: VBoxContainer = %MainMenu
@onready var play_btn: Button = $MenuContainer/MainMenu/PlayBtn
@onready var practice_btn: Button = $MenuContainer/MainMenu/PracticeBtn
@onready var settings_btn: Button = $MenuContainer/MainMenu/SettingsBtn
@onready var how_to_play_btn: Button = $MenuContainer/MainMenu/HowToPlayBtn
@onready var quit_btn: Button = $MenuContainer/MainMenu/QuitBtn
@onready var easy_btn: Button = $DifficultyMenu/EasyBtn
@onready var menu_background_color: ColorRect = $MenuBackgroundColor
@onready var menu_textbox: VBoxContainer = %MenuTextbox
@onready var exit_menu: Control = $ExitMenu
@onready var settings: TabContainer = %Settings
@onready var difficulty_menu: VBoxContainer = %DifficultyMenu
@onready var minigames_menu: VBoxContainer = %MinigamesMenu
@onready var how_to_play: TabContainer = %HowToPlay
@onready var back_button: BackButton = $BackButton
@onready var return_btn: Button = $MinigamesMenu/ReturnBtn
@onready var margin_container: MarginContainer = $MinigamesMenu/MarginContainer
@onready var menu_container: HBoxContainer = $MenuContainer
@onready var fractions_minigame: Button = $MinigamesMenu/FractionsMinigame
@onready var additions_minigame: Button = $MinigamesMenu/AdditionsMinigame


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
	
	if self.settings.is_visible_in_tree():
		self.settings.hide()
	elif self.difficulty_menu.is_visible_in_tree():
		if PlayerSession.is_practice_mode():
			# Si es el modo práctica se desactiva:
			PlayerSession.change_practice_mode()
		self.difficulty_menu.hide()
	elif self.minigames_menu.is_visible_in_tree():
		if PlayerSession.is_practice_mode():
			# Si es el modo práctica se desactiva:
			PlayerSession.change_practice_mode()
		self.minigames_menu.hide()
	elif self.how_to_play.is_visible_in_tree():
		self.how_to_play.hide()
	else:
		return
	# Se muestra el menú principal:
	self.menu_container.show()
	# Se verifica el modo de entrada:
	if !Mouse.mouse_mode_activated:
		self.play_btn.grab_focus() # Se enfoca el botón play
	%BackButton.hide()


func _on_exit_menu_no_pressed() -> void:
	if self.minigames_menu.is_visible_in_tree():
		if not PlayerSession.is_practice_mode():
			self.fractions_minigame.grab_focus()
		else:
			self.additions_minigame.grab_focus()
	if self.difficulty_menu.is_visible_in_tree():
		self.easy_btn.grab_focus()
	elif self.settings.is_visible_in_tree():
		self.settings.get_tab_bar().grab_focus() # Enfoca la TabBar de Video
	elif self.how_to_play.is_visible_in_tree():
		self.how_to_play.get_tab_bar().grab_focus() # Enfoca la TabBar de Video
	self.exit_menu.hide()


func _on_info_screen_visibility_changed() -> void:
	if %InfoScreen.is_visible_in_tree():
		# Se suelta el focus:
		get_viewport().gui_release_focus()
		# Si es visible se desactiva el botón de regresar:
		Mouse.disable_action("ui_cancel")


func _on_info_screen_hidden() -> void:
	if self.difficulty_menu.is_visible_in_tree():
		# El botón easy_btn obtiene el focus:
		self.easy_btn.grab_focus()
	# Se reactiva el botón de cancelar:
	Mouse.enable_action("ui_cancel")
