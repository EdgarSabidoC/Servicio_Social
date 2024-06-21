extends Control

@onready var moving_text = $MarginContainer/MovingText
enum AlignmentType {LEFT=0,RIGHT=1,CENTER=2,FILL=3}
@export var alignment: AlignmentType
@onready var margin_container = $MarginContainer
var eof: bool = false
var end_of_paragraph: bool = false
var paragraphs = "[StartParagraph]Esta es una línea de texto. Esta es otra línea de texto, blah, blah, blah.[StartParagraph]Segundo párrafo: blah, blah, blah, blah, blah, blah, blah.".split("[StartParagraph]")
var length: int
var current_paragraph: int = 0
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Señal que indica si ya se terminó el párrafo final:
signal final_paragraph_finished


func _ready() -> void:
	self.hide()


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
			self.eof = true
			self.final_paragraph_finished.emit()
		self.end_of_paragraph = false
	else:
		self.moving_text.seconds = 0.1/2


func start() -> void:
	animation_player.play("augment")
	self.pivot_offset = self.size/2
	if self.paragraphs[self.current_paragraph] == "":
		self.current_paragraph += 1
	self.print_message(self.paragraphs[self.current_paragraph])
	self.length = len(self.paragraphs)-1


# Imprime una cadena que se la pase y la alineación [l: left, c: center, r: right, f: fill]:
func print_message(string: String) -> void:
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


func _on_final_paragraph_finished() -> void:
	# Se queda esperando una entrada ui_accept o m1:
	var cont: bool = false
	while !cont:
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("m1"):
			print_debug("Párrafo final: Finalizó el texto")
			cont = true
			animation_player.play("reduce")
