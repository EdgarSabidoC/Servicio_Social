extends Control

class_name Clock

#@onready var minutes_label: Label = $CanvasLayer/Panel/MinutesLabel
#@onready var seconds_label: Label = $CanvasLayer/Panel/SecondsLabel
#@onready var milliseconds_label: Label = $CanvasLayer/Panel/MillisecondsLabel
@onready var label: Label = $Panel/Label
@export var time: float = 0.0
@onready var minutes: int = 0
@onready var seconds: int = 0
@onready var milliseconds: int = 0
@onready var color_changed: bool = false
@onready var signal_emitted: bool


signal new_minute_reached


func _process(delta: float) -> void:
	self.time += delta
	@warning_ignore("narrowing_conversion")
	self.milliseconds = fmod(time, 1) * 100
	@warning_ignore("narrowing_conversion")
	self.seconds = fmod(time, 60)
	@warning_ignore("narrowing_conversion")
	self.minutes = fmod(time, 3600) / 60
	
	# Si se llega al minuto, se lanza la señal new_minute_reached:
	if !self.signal_emitted and self.seconds == 59 and self.milliseconds == 99:
		self.signal_emitted = true
		self.color_changed = false
		self.new_minute_reached.emit()
		
	# Se cambia el color según los minutos:
	set_timer_color()
	
	# Se imprime el tiempo en la etiqueta ya con formato:
	get_time_formatted()


# Para el reloj:
func stop() -> void:
	set_process(false)


# Continúa con el proceso del reloj:
func continue_clock() -> void:
	set_process(true)


# Configura el color del reloj:
func set_timer_color() -> void:
	# Se cambia el color a rojo:
	match self.minutes:
		1:
			if !self.color_changed:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.lightened(0.75))
		2:
			if !self.color_changed:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.lightened(0.55))
		3:
			if !self.color_changed:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.lightened(0.25))
		4:
			if !self.color_changed:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.darkened(0.15))
		5:
			if !self.color_changed:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED)
		6:
			if !self.color_changed:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.darkened(0.15))
		7:
			if !self.color_changed:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.darkened(0.30))
		8:
			if !self.color_changed:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.darkened(0.45))
		9:
			if !self.color_changed:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.darkened(0.5))
		10:
			if !self.color_changed:
				self.color_changed = true
				self.label.set("theme_override_colors/font_color", Color.RED.darkened(0.75))

# Imprime en una etiqueta el formato del reloj:
func get_time_formatted() -> void:
	self.label.text = "%02d:%02d.%02d" % [self.minutes, self.seconds, self.milliseconds]


func hide_clock():
	self.hide()


func show_clock():
	self.show()
	

# Imprime en las etiquetas el formato del reloj:
#func get_time_labels() -> void:
	#self.minutes_label.text = "%02d:"%self.minutes
	#self.seconds_label.text = "%02d."%self.seconds
	#self.milliseconds_label.text = "%02d."%self.milliseconds
