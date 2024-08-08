extends Button

## Button that returns to main menu
class_name BackButton


@onready var main_menu: VBoxContainer = %MainMenu
@onready var settings: TabContainer = %Settings
@onready var play_btn: Button = $"../MenuContainer/MainMenu/PlayBtn"
@onready var text_box_container: Control = %MenuTextbox
@onready var menu_background_color = $"../MenuBackgroundColor"
@onready var settings_background_color = $"../SettingsBackgroundColor"
@onready var how_to_play: TabContainer = %HowToPlay
@onready var menu_container: HBoxContainer = $"../MenuContainer"



func _ready() -> void:
	# Se oculta el botón en el modo teclado:
	if !Mouse.mouse_mode_activated:
		self.hide()
	self.text = "Regresar"
	self.pressed.connect(self.on_pressed)


# Oculta el menú de opciones y muestra el menú principal:
func on_pressed():
	if self.settings.is_visible_in_tree():
		self.menu_background_color.fade_in() # Realiza un fade in al fondo del menú
		self.settings.current_tab = 0 # Se selecciona la TabBar de Video
		# Se muestra el menú principal:
		self.menu_container.show()
		self.main_menu.show()
		self.text_box_container.show() # Se muestra el textbox del menú principal
		if !Mouse.mouse_mode_activated:
			self.play_btn.grab_focus() # Se enfoca el botón play
			self.hide()
		self.settings.hide() # Se oculta el menú de opciones de configuración
	elif self.how_to_play.is_visible_in_tree():
		self.menu_background_color.fade_in() # Realiza un fade in al fondo del menú
		self.how_to_play.current_tab = 0 # Se selecciona la TabBar de Video
		# Se muestra el menú principal:
		self.menu_container.show()
		self.main_menu.show()
		self.text_box_container.show() # Se muestra el textbox del menú principal
		if !Mouse.mouse_mode_activated:
			self.play_btn.grab_focus() # Se enfoca el botón play
		self.how_to_play.hide() # Se oculta el menú de opciones de configuración
	self.hide()


func _on_mouse_entered() -> void:
	Sfx.play_sound(Sfx.Sounds.KEY_PRESS, 10)
