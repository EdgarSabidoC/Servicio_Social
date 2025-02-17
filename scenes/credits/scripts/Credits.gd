extends Control

@onready var credits_label: RichTextLabel = $CreditsLabel
@onready var body_credits_label: Label = $BodyCreditsLabel
@onready var link_button: LinkButton = $LinkButton
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var notification_label: RichTextLabel = $NotificationLabel
@export var cancel_width: float = 0
@export var cancel_height: float = 30
@onready var cancel_texture_path: String = "res://addons/ActionIcon/Keyboard/Esc.png"
@onready var m1_texture_path: String = "res://addons/ActionIcon/Mouse/Left.png"

# Escena del menú principal:
@onready var main_menu: PackedScene = load("res://scenes/main_menu/MainScene.tscn")

@onready var animations: Array[String] = [
	"alux_sad",
	"alux_angry",
	"alux_dancing",
	"zotz_in",
	"zotz_sad",
	"zotz_angry",
	"zotz_dancing",
	"toh_in",
	"toh_dancing",
	"huolpoch_in",
	"huolpoch_sad",
	"huolpoch_angry",
	"huolpoch_dancing",
	"keken_sad",
	"keken_angry",
	"keken_dancing",
]

@onready var titles: Array[String] = [
	"DESARROLLADO POR",
	"PARA EL PROYECTO",
	"RESPONSABLE DEL PROYECTO",
	"ARTE y DISEÑO",
	"MÚSICA y SFX",
	"CANCIONES",
	"AGRADECIMIENTOS ESPECIALES"
]

# Lista de cadenas para los créditos
@export var credits_list: Array = [
	"💻 DESARROLLADO POR",
	"Edgar",
	"Carlos",
	"PARA EL PROYECTO",
	"Aprende, juega y diviérte con Linux 🐧",
	"RESPONSABLE DEL PROYECTO",
	"M. en T. María del Carmen Zozaya Ayuso",
	"🎨 ARTE y DISEÑO",
	"Carlos",
	"🎶 MÚSICA y SFX",
	"Edgar",
	"CANCIONES",
	"🎵 \"Tarantella napoletana\"\nComposición tradicional napolitana",
	"🎵 \"Funiculì, funiculà\"\nCompositor: Luigi Denza\nLetra: Peppino Turco",
	"🎵 \"’O sole mio\"\nCompositor: Eduardo di Capua\nLetra: Giovanni Capurro",
	"AGRADECIMIENTOS ESPECIALES",
	"Universidad Autónoma de Yucatán\n(UADY)",
	"Facultad de Matemáticas - UADY",
	"Y a ti ❤️",
	"¡Gracias por jugar!\n\n😄"
]

@onready var total_time: float = 0

# Tiempo de fade in, tiempo de pausa, y tiempo de fade out
@export var fade_in_time: float = 1.0
@export var display_time: float = 2.0
@export var fade_out_time: float = 1.0

@onready var current_index: int = 0
@onready var used_animations: Array[String] = []
@onready var current_animation: String


signal show_next
signal finished


func _ready():
	# Inicializa el LinkButton como invisible
	link_button.modulate.a = 0
	
	# Se conecta la señal de finalización:
	self.finished.connect(_go_to_main_menu)

	# Conecta la señal para mostrar el siguiente crédito
	self.show_next.connect(_show_next_credit)

	# Inicializa el primer crédito
	self.show_next.emit()
	# Se inicia la animación inicial
	self.animated_sprite_2d.play("default")
	
	print_debug("Mouse mode: ",Mouse.mouse_mode_activated)
	if Mouse.mouse_mode_activated:
		self.notification_label.text = "[center]Mantén presionado [img={cancel_width}x{cancel_height}]{m1}[/img] para salir...[/center]".format({"cancel_width": str(self.cancel_width), "cancel_height": str(self.cancel_height), "m1": self.m1_texture_path})
	else:
		self.notification_label.text = "[center]Mantén presionado [img={cancel_width}x{cancel_height}]{cancel}[/img] para salir...[/center]".format({"cancel_width": str(self.cancel_width), "cancel_height": str(self.cancel_height), "cancel": self.cancel_texture_path
		
		})

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_cancel") or Input.is_action_pressed("m1"):
		self.total_time += delta
	if Input.is_action_just_released("ui_cancel") or Input.is_action_just_released("m1"):
		self.total_time = 0
		if self.notification_label:
			self.notification_label.hide()
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("m1"):
		self.notification_label.show()
	if self.total_time >= 2:
		self._go_to_main_menu()


func _go_to_main_menu() -> void:
	SceneTransition.change_scene(main_menu)
	var volume: float = -10
	var current_position: float = 0
	BackgroundMusic.start_menu_song(volume, current_position)


func _show_next_credit():
	if current_index >= credits_list.size():
		finished.emit()
		return # Termina si no hay más créditos

	var current_item = credits_list[current_index]

	if current_item == "Edgar":
		self._play_random_animation()
		_show_developer("Edgar Sabido Cortés", "https://github.com/EdgarSabidoC")
	elif current_item == "Carlos":
		self._play_random_animation()
		_show_developer("Carlos Antonio Ruiz Domínguez", "https://github.com/carlosruiz01")
	elif current_item in titles:
		_show_title(current_item)
	else:
		self._play_random_animation()
		_show_body_text(current_item)
	current_index += 1


func _show_title(text: String):
	credits_label.text = text
	credits_label.modulate.a = 0 # Inicialmente transparente

	# Crea un nuevo Tween para esta animación
	var tween = create_tween()
	
	# Anima el fade in
	tween.tween_property(credits_label, "modulate:a", 1.0, fade_in_time)
	# Pausa para el tiempo de display
	tween.tween_interval(display_time)
	# Anima el fade out
	tween.tween_property(credits_label, "modulate:a", 0.0, fade_out_time)

	# Conecta la señal "finished" del Tween para mostrar el siguiente crédito
	tween.finished.connect(_on_tween_finished)


func _show_body_text(text: String):
	body_credits_label.text = text
	body_credits_label.modulate.a = 0 # Inicialmente transparente

	# Crea un nuevo Tween para esta animación
	var tween = create_tween()
	
	# Anima el fade in
	tween.tween_property(body_credits_label, "modulate:a", 1.0, fade_in_time)
	# Pausa para el tiempo de display
	tween.tween_interval(display_time)
	# Anima el fade out
	tween.tween_property(body_credits_label, "modulate:a", 0.0, fade_out_time)

	# Conecta la señal "finished" del Tween para mostrar el siguiente crédito
	tween.finished.connect(_on_tween_finished)


func _show_developer(developer: String, github_url: String):
	link_button.text = developer
	link_button.uri = github_url
	link_button.show()
	link_button.modulate.a = 0 # Inicialmente transparente

	# Crea un nuevo Tween para esta animación
	var tween = create_tween()
	
	# Anima el fade in
	tween.tween_property(link_button, "modulate:a", 1.0, fade_in_time)
	# Pausa para el tiempo de display
	tween.tween_interval(display_time)
	# Anima el fade out
	tween.tween_property(link_button, "modulate:a", 0.0, fade_out_time)
	
	# Conecta la señal "finished" del Tween para ocultar el botón y mostrar el siguiente crédito
	tween.finished.connect(func() -> void: link_button.hide())
	tween.finished.connect(_on_tween_finished)


func _on_tween_finished() -> void:
	emit_signal("show_next")


# Función para obtener un string aleatorio del array de animaciones sin repeticiones
func _get_random_animation() -> String:
	if self.animations.size() == 0:
		return ""  # Retorna un string vacío si el array está vacío

	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_index: int = rng.randi_range(0, animations.size() - 1)
	var selected_animation: String = self.animations[random_index]

	# Marca la animación como usada
	print_debug(selected_animation)
	self.animations.remove_at(random_index)

	return selected_animation


func _change_animation() -> void:
	self.current_animation = _get_random_animation()
	match self.current_animation:
		"default":
			self.animated_sprite_2d.animation = "default"
			self.animated_sprite_2d.position = Vector2(0, 259)
		"alux_dancing":
			self.animated_sprite_2d.animation = "alux_dancing"
			self.animated_sprite_2d.position = Vector2(816, 304)
		"alux_angry":
			self.animated_sprite_2d.animation = "alux_angry"
			self.animated_sprite_2d.position = Vector2(816, 304)
		"alux_sad":
			self.animated_sprite_2d.animation = "alux_sad"
			self.animated_sprite_2d.position = Vector2(816, 304)
		"toh_in":
			self.animated_sprite_2d.animation = "toh_in"
			self.animated_sprite_2d.position = Vector2(408, 302)
		"toh_dancing":
			self.animated_sprite_2d.animation = "toh_dancing"
			self.animated_sprite_2d.position = Vector2(408, 302)
		"keken_angry":
			self.animated_sprite_2d.animation = "keken_angry"
			self.animated_sprite_2d.position = Vector2(815, 321)
		"keken_sad":
			self.animated_sprite_2d.animation = "keken_sad"
			self.animated_sprite_2d.position = Vector2(815, 321)
		"keken_dancing":
			self.animated_sprite_2d.animation = "keken_dancing"
			self.animated_sprite_2d.position = Vector2(815, 321)
		"zotz_in":
			self.animated_sprite_2d.animation = "zotz_in"
			self.animated_sprite_2d.position = Vector2(813, 0)
		"zotz_angry":
			self.animated_sprite_2d.animation = "zotz_angry"
			self.animated_sprite_2d.position = Vector2(813, 0)
		"zotz_sad":
			self.animated_sprite_2d.animation = "zotz_sad"
			self.animated_sprite_2d.position = Vector2(813, 0)
		"zotz_dancing":
			self.animated_sprite_2d.animation = "zotz_dancing"
			self.animated_sprite_2d.position = Vector2(813, 0)
		"huolpoch_in":
			self.animated_sprite_2d.animation = "huolpoch_in"
			self.animated_sprite_2d.position = Vector2(0, 0)
		"huolpoch_sad":
			self.animated_sprite_2d.animation = "huolpoch_sad"
			self.animated_sprite_2d.position = Vector2(0, 0)
		"huolpoch_angry":
			self.animated_sprite_2d.animation = "huolpoch_angry"
			self.animated_sprite_2d.position = Vector2(0, 0)
		"huolpoch_dancing":
			self.animated_sprite_2d.animation = "huolpoch_dancing"
			self.animated_sprite_2d.position = Vector2(0, 0)


func _play_random_animation() -> void:
	self._change_animation()
	self.animated_sprite_2d.play()
