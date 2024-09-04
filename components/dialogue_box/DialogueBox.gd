extends Control

@onready var moving_text = $MarginContainer/MovingText
enum AlignmentType {LEFT=0,RIGHT=1,CENTER=2,FILL=3}
## Alignment type for the printed message
@export var alignment: AlignmentType
@onready var margin_container = $MarginContainer
var eof: bool = false
var end_of_paragraph: bool = false
## Text to print as message in the dialogue box. Use [StartParagraph] to mark where a paragraph starts in a String.
@export_multiline var text: String = "[StartParagraph]This is a paragraph.[StartParagraph]This is the second paragraph."
@onready var paragraphs: PackedStringArray = []
var length: int
var current_paragraph: int = 0
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var finished: bool = false
@onready var dots_label: Label = $DotsLabel


# Señales:
## The signal is emitted when the last paragraph is finished.
signal final_paragraph_finished
## The signal is emitted when the dialogue box is closed.
signal dialogue_box_closed


func _ready() -> void:
	self.set_process(false)
	self.set_process_input(false)


func _process(_delta: float) -> void:
	if self.paragraphs[self.current_paragraph] == "":
		self.current_paragraph += 1
	if (Input.is_action_pressed("ui_accept") or Input.is_action_pressed("m1")) and !self.end_of_paragraph:
		self.moving_text.seconds = 0.05/4
	elif (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("m1")) and self.end_of_paragraph:
		print_debug("Finalizó un párrafo")
		if self.current_paragraph < self.length:
			self.current_paragraph += 1
			# Se imprime el siguiente párrafo:
			self.print_message(self.paragraphs[self.current_paragraph])
		else:
			self.current_paragraph = 0
			self.eof = true
			self.final_paragraph_finished.emit()
			print_debug("Finalizó el texto")
		self.end_of_paragraph = false
	else:
		self.moving_text.seconds = 0.1/2


func _input(event: InputEvent) -> void:
	if self.finished and (event.is_action_released("ui_accept") or event.is_action_released("m1")):
		# Se considera el evento como manejado:
		get_tree().root.set_input_as_handled()
		self.accept_event() # Se acepta el evento
		self.set_process_input(false) # Se deja de escuchar
		self.animation_player.play("reduce") # Animación de reducción de la caja de diálogos
		self.dialogue_box_closed.emit() # Se emite la señal de cerrado de la caja de diálogos


# Esta función depende del texto cargado previamente. Cargarlo utilizando load_message().
func start() -> void:
	self.set_process(true)
	self.animation_player.play("augment")
	self.paragraphs = self.text.split("[StartParagraph]")
	print_debug(self.text)
	self.pivot_offset = self.size/2
	if self.paragraphs.size() <= 0:
		return
	if self.paragraphs[self.current_paragraph] == "":
		self.current_paragraph += 1
	self.print_message(self.paragraphs[self.current_paragraph])
	self.length = len(self.paragraphs)-1


# Carga el texto (debe ser llamado antes de start).
func load_message(message: String = self.text):
	print_debug("Loaded message: ", message)
	self.text = message


# Imprime una cadena que se la pase y la alineación [l: left, c: center, r: right, f: fill]:
func print_message(string: String) -> void:
	if self.dots_label.is_visible_in_tree():
		self.dots_label.hide()
	match self.alignment:
		self.AlignmentType.LEFT:
			self.moving_text.text = "[left]%s[/left]" %string
		self.AlignmentType.CENTER:	
			self.moving_text.text = "[center]%s[/center]" %string
		self.AlignmentType.RIGHT:
			self.moving_text.text = "[right]%s[/right]" %string
		self.AlignmentType.FILL:
			self.moving_text.text = "[fill]%s[/fill]" %string
	self.moving_text.move_text()


# Limpia el mensaje (imprime una cadena predeterminada):
func clear_message() -> void:
	if !self.moving_text.text.is_empty():
		self.moving_text.text = self.text
		self.moving_text.move_text()


func _on_moving_text_end_of_text() -> void:
	self.end_of_paragraph = true
	if self.current_paragraph < self.paragraphs.size()-1:
		self.dots_label.show()


func _on_final_paragraph_finished() -> void:
	self.finished = true
	self.set_process_input(true)
