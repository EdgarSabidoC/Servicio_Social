extends Node2D

class_name Clock

@onready var label: Label = $CanvasLayer/Panel/Label
@export var time: float = 0.0
@onready var minutes: int = 0
@onready var seconds: int = 0
@onready var milliseconds: int = 0

func _process(delta: float) -> void:
	self.time += delta
	self.milliseconds = fmod(time, 1) * 100
	self.seconds = fmod(time, 60)
	self.minutes = fmod(time, 3600) / 60
	
	# Se cambia el color a rojo:
	if minutes >= 1:
		var red = Color(1.0,0.0,0.0,1.0)
		label.set("theme_override_colors/font_color", red)
	
	# Se imprime el tiempo en la etiqueta ya con formato:
	label.text = get_time_formatted()


# Para el reloj:
func stop() -> void:
	set_process(false)


# Devuelve una cadena con el formato del reloj:
func get_time_formatted() -> String:
	return "%02d:%02d.%03d" % [self.minutes, self.seconds, self.milliseconds]
