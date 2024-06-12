extends Control

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


func _ready() -> void:
	# Si se supera el máximo puntaje:
	#if Persistence.is_high_score():
	user_input_string.show()
	button.show()
	accept.action_name = "ui_accept"
	accept_texture_path = accept._get_keyboard(Mouse.input_actions["ui_accept"][0].keycode).get_path()


func _on_button_pressed() -> void:
	if user_input_string.text != "":
		user_input_string.save_user_name() # Se guarda la cadena ingresada
	else:
		user_input_string.default_user_name() # Se guarda un nombre predeterminado
	user_input_string.hide()
	button.hide()
	# Se actualiza el puntaje:
	Persistence.update_high_scores()
	# Se obtiene el formato de los puntajes:
	rich_text_label.text = Persistence.get_high_scores_formatted()
	# Se añade a los mejores puntajes
	v_box_container.show() # Se muestra la pantalla de puntajes.
	
	rich_text_label_text_flash_2.text = "[center]Presiona [img={accept_width}x{accept_height}]{accept}[/img] para continuar[/center]".format({"accept_width": str(accept_width), "accept_height": str(accept_height), "accept": accept_texture_path})
	
	# Si están desactivadas las teclas:
	if Mouse.mouse_mode_activated:
		Mouse.change_mode()
		Mouse.enable_actions()
		changed = true
	
	self.exit = true


func _input(_event: InputEvent) -> void:
	# Test debug
	print_debug("Entró a Input en EndCutscene con %s" % exit)
	if self.exit and Input.is_action_just_pressed("ui_accept"):
		# Test debug
		print_debug("Leyó el input de accept en EndCutscene")
		
		# Se reinicia la sesión de jugador:
		PlayerSession.clear_player_session()
		
		# Se realiza el cambio de escena:
		SceneTransition.change_scene(title_screen_scene)
