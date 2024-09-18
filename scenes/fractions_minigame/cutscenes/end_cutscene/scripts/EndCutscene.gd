extends Control

@onready var main_menu_scene: PackedScene = load("res://scenes/main_menu/MainScene.tscn")
@onready var user_input_string: UserInputString = $UserInputString
@onready var button: Button = $Button
@onready var player: Dictionary
@onready var exit: bool = false
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var rich_text_label_text_flash: RichTextLabelTextFlash = $VBoxContainer/RichTextLabelTextFlash
@onready var rich_text_label: RichTextLabel = $VBoxContainer/RichTextLabel
@onready var rich_text_label_text_flash_2: RichTextLabelTextFlash = $VBoxContainer/RichTextLabelTextFlash2
@onready var accept_texture_path: String
@onready var m1_texture_path: String
@onready var action_icon: ActionIcon
@onready var changed: bool = false
@onready var user_input_label: Label = $UserInputLabel

@export var accept_width: float = 60
@export var accept_height: float = 50

@export var m1_width: float = 0
@export var m1_height: float = 50


func _ready() -> void:
	# Se cambia la canción:
	var current_position: float = 0
	var pitch: float = 1.0
	var volume: float = 0
	BackgroundMusic.change_song(BackgroundMusic.Songs.FUNICULI_FUNICULA_FASTER, current_position, pitch, volume)
	
	# Botones que aparecen para continuar y salir de la pantalla de puntajes altos:
	action_icon = ActionIcon.new()
	self.action_icon.action_name = "ui_accept"
	self.accept_texture_path = self.action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	self.action_icon.action_name = "m1"
	self.m1_texture_path = self.action_icon._get_mouse(MOUSE_BUTTON_LEFT).get_path()
	
	# Si se supera el máximo puntaje:
	if Persistence.is_high_score():
		self.user_input_label.show()
		self.user_input_string.show()
		self.user_input_string.grab_focus()
		self.button.show()
	else:
		# Si no se supera, sólo se muestran los máximos puntajes:
		Sfx.play_sound(Sfx.Sounds.SCORE_SCREEN)
		self._get_high_scores()
		self.exit = true


# Función que muestra los máximos puntajes:
func _get_high_scores() -> void:
	self.v_box_container.show() # Se muestra la pantalla de puntajes.
	self.rich_text_label.text = Persistence.get_high_scores_formatted()
	self.rich_text_label_text_flash_2.text = "[center]Presiona [img={accept_width}x{accept_height}]{accept}[/img] o [img={m1_width}x{m1_height}]{m1}[/img] para continuar[/center]".format({"accept_width": str(accept_width), "accept_height": str(accept_height), "accept": accept_texture_path, "m1_width": str(m1_width), "m1_height": str(m1_height), "m1": m1_texture_path})


func _on_button_pressed() -> void:
	Sfx.play_sound(Sfx.Sounds.BUTTON_ACCEPT)
	await get_tree().create_timer(0.5).timeout
	if self.user_input_string.text != "":
		self.user_input_string.save_user_name() # Se guarda la cadena ingresada
	else:
		self.user_input_string.default_user_name() # Se guarda un nombre predeterminado
	self.user_input_label.hide()
	self.user_input_string.hide()
	self.button.hide()
	
	# Se añade a los mejores puntajes
	Persistence.update_high_scores()
	
	Sfx.play_sound(Sfx.Sounds.SCORE_SCREEN)
	
	# Se obtienen los mejores puntajes
	self._get_high_scores()
	
	self.exit = true


func _input(_event: InputEvent) -> void:
	if self.exit and (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("m1")):
		Sfx.play_sound(Sfx.Sounds.BUTTON_ACCEPT)
		# Consume el evento:
		get_viewport().set_input_as_handled()
		self.rich_text_label_text_flash_2.speed = 60
		
		if not Mouse.mouse_mode_activated:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
		# Espera un poco para visualizar el efecto del parpadeo de la etiqueta:
		await get_tree().create_timer(0.5).timeout
		
		# Se borra la sesión de jugador:
		PlayerSession.clear_player_session()
	
		# Se borran los datos de los problemas de los personajes:
		CharactersData.clear_data()
			
		# Se realiza el cambio de escena:
		SceneTransition.change_scene(self.main_menu_scene)
		
		# Se cambia la música a la del menú:
		var volume: float = -10
		var current_position: float = 0
		BackgroundMusic.start_menu_song(volume, current_position)
