extends Control

const FUNICULI_FUNICULA_FASTER: AudioStream = preload("res://assets/sounds/music/funiculi_funicula_faster.ogg")
const TARANTELLA_NAPOLETANA_TREMOLO: AudioStream = preload("res://assets/sounds/music/tarantella_napoletana_tremolo.ogg")
@onready var title_screen_scene: PackedScene = load("res://scenes/title_screen/TitleScreen.tscn")
@onready var user_input_string: UserInputString = $UserInputString
@onready var button: Button = $Button
@onready var player: Dictionary
@onready var exit: bool = false
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var rich_text_label_text_flash: RichTextLabelTextFlash = $VBoxContainer/RichTextLabelTextFlash
@onready var rich_text_label: RichTextLabel = $VBoxContainer/RichTextLabel
@onready var rich_text_label_text_flash_2: RichTextLabelTextFlash = $VBoxContainer/RichTextLabelTextFlash2
@onready var accept_texture_path: String = "res://addons/ActionIcon/Keyboard/Enter.png"
@onready var accept: ActionIcon = ActionIcon.new()
@export var accept_width: float = 0
@export var accept_height: float = 30
@onready var changed: bool = false
@onready var user_input_label: Label = $UserInputLabel



func _ready() -> void:
	# Se cambia la canción:
	var current_position: float = 0
	var pitch: float = 1.0
	var volume: float = 0
	BackgroundMusic.change_song(FUNICULI_FUNICULA_FASTER, current_position, pitch, volume)
	
	# Si se supera el máximo puntaje:
	if Persistence.is_high_score():
		self.user_input_label.show()
		self.user_input_string.show()
		self.button.show()
	else:
		# Si no se supera, sólo se muestran los máximos puntajes:
		self._get_high_scores()
		self.exit = true
	
	# Botón que aparece para continuar y salir de la pantalla de puntajes altos:
	if !Mouse.mouse_mode_activated:
		self.user_input_string.grab_focus()
		self.accept.action_name = "ui_accept"
		self.accept_texture_path = self.accept._get_keyboard(InputMap.action_get_events("ui_accept")[0].keycode).get_path()
	else:
		# Si está activado el modo mouse:
		self.accept.action_name = "m1"
		self.accept_texture_path = self.accept._get_mouse(InputMap.action_get_events("m1")[0].button_index).get_path()
	self.accept.refresh()

# Función que muestra los máximos puntajes:
func _get_high_scores() -> void:
	self.v_box_container.show() # Se muestra la pantalla de puntajes.
	self.rich_text_label.text = Persistence.get_high_scores_formatted()
	self.rich_text_label_text_flash_2.text = "[center]Presiona [img={accept_width}x{accept_height}]{accept}[/img] para continuar[/center]".format({"accept_width": str(accept_width), "accept_height": str(accept_height), "accept": accept_texture_path})


func _on_button_pressed() -> void:
	if self.user_input_string.text != "":
		self.user_input_string.save_user_name() # Se guarda la cadena ingresada
	else:
		self.user_input_string.default_user_name() # Se guarda un nombre predeterminado
	self.user_input_label.hide()
	self.user_input_string.hide()
	self.button.hide()
	
	# Se añade a los mejores puntajes
	Persistence.update_high_scores()
	
	# Se obtienen los mejores puntajes
	self._get_high_scores()
	
	# Si están desactivadas las teclas:
	if Mouse.mouse_mode_activated:
		Mouse.change_mode()
		Mouse.enable_actions()
		self.changed = true
	
	self.exit = true


func _input(_event: InputEvent) -> void:
	if self.exit and (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("m1")):
		# Consume el evento:
		get_viewport().set_input_as_handled()
		self.rich_text_label_text_flash_2.speed = 60
		
		# Espera un poco para visualizar el efecto del parpadeo de la etiqueta:
		await get_tree().create_timer(0.5).timeout
		
		# Se borra la sesión de jugador:
		PlayerSession.clear_player_session()
	
		# Se borran los datos de los problemas de los personajes:
		CharactersData.clear_data()
			
		# Se realiza el cambio de escena:
		SceneTransition.change_scene(self.title_screen_scene)
		
		# Se cambia la música a la del menú:
		BackgroundMusic.change_song(self.TARANTELLA_NAPOLETANA_TREMOLO)
