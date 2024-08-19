extends VBoxContainer

@onready var menu_textbox: MarginContainer = $MarginContainer/MenuTextbox
@onready var fractions_minigame: Button = $FractionsMinigame
@onready var additions_minigame: Button = $AdditionsMinigame
@onready var margin_container: MarginContainer = $MarginContainer
@onready var settings_background_color: ColorRect = $"../SettingsBackgroundColor"
@onready var menu_background_color: ColorRect = $"../MenuBackgroundColor"


func _ready() -> void:
	self.menu_textbox.print_message(self.menu_textbox.default_text, "c")


func _on_visibility_changed() -> void:
	if self.is_visible_in_tree():
		self.settings_background_color.fade_in()
		self.menu_background_color.fade_out()
		self.margin_container.show()
		if PlayerSession.is_practice_mode():
			# Si es modo práctica, se oculta el botón del minijuego de fracciones:
			self.fractions_minigame.hide()
			if !Mouse.mouse_mode_activated:
				self.additions_minigame.grab_focus()
			await get_viewport().gui_focus_changed
		elif !Mouse.mouse_mode_activated:
			self.fractions_minigame.show()
			self.fractions_minigame.grab_focus()
