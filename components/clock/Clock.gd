extends Control

class_name Clock


@onready var label: Label = $Panel/Label
@export var time: float = 0.0
@onready var minutes: int = 0
@onready var seconds: int = 0
@onready var milliseconds: int = 0
@onready var color_changed: bool = false
@onready var signal_emitted: bool
@export var countdown: bool = false
@export var countdown_pivot_1: int = 59
@export var countdown_pivot_2: int = 45
@export var countdown_pivot_3: int = 30
@export var countdown_pivot_4: int = 15
@onready var animated_texture_rect: AnimatedTextureRect = $AnimatedTextureRect


signal new_minute_reached
signal countdown_finished


func _ready() -> void:
	# Se inicializa la animación del reloj desde el frame 0:
	self.animated_texture_rect.frame_index = 0


func _process(delta: float) -> void:
	if !self.countdown:
		self.time += delta
	elif self.countdown and self.time > 0:
		self.time -= delta
	elif self.countdown and self.time <= 0:
		self.countdown_finished.emit()
		self.stop()
	@warning_ignore("narrowing_conversion")
	self.milliseconds = fmod(self.time, 1) * 100
	@warning_ignore("narrowing_conversion")
	self.seconds = fmod(self.time, 60)
	@warning_ignore("narrowing_conversion")
	self.minutes = fmod(self.time, 3600) / 60
	
	# Si se llega al minuto, se lanza la señal new_minute_reached:
	if !self.countdown and !self.signal_emitted and self.seconds == 59 and self.milliseconds == 99:
		self.signal_emitted = true
		self.color_changed = false
		self.new_minute_reached.emit()
	
	if self.countdown and (fmod(self.seconds, 14) == 0):
		self.color_changed = false
	
	# Se cambia el color según los minutos:
	self.set_timer_color()
	
	# Se imprime el tiempo en la etiqueta ya con formato:
	if self.time >= 0:
		self.get_time_formatted()


# Para el reloj:
func stop() -> void:
	self.animated_texture_rect.pause()
	self.set_process(false)


# Continúa con el proceso del reloj:
func continue_clock() -> void:
	self.animated_texture_rect.play()
	self.set_process(true)


# Configura el color del reloj:
func set_timer_color() -> void:
	# Se cambia el color a rojo:
	if !self.color_changed and !self.countdown:
		# Si no es cuenta atrás:
		match self.minutes:
			1:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.lightened(0.75))
			2:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.lightened(0.55))
			3:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.lightened(0.25))
			4:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.lightened(0.15))
			5:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED)
			6:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.darkened(0.15))
			7:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.darkened(0.30))
			8:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.darkened(0.45))
			9:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.darkened(0.5))
			10:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.darkened(0.75))
	elif !self.color_changed and self.countdown and self.minutes < 1:
		# Si es cuenta atrás:
		match self.seconds:
			countdown_pivot_1:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.lightened(0.75))
			countdown_pivot_2:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.lightened(0.55))
			countdown_pivot_3:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.lightened(0.35))
			countdown_pivot_4:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED)


# Imprime en una etiqueta el formato del reloj:
func get_time_formatted() -> void:
	self.label.text = "%02d:%02d:%02d" % [self.minutes, self.seconds, self.milliseconds]


func hide_clock():
	self.hide()


func show_clock():
	self.show()
