class_name SplashScreen extends Control

@export var _time: float = 3
@export var _fade_time: float = 1

signal finished()


# Inicia el fade:
func start() -> void:
	modulate.a = 0
	self.show()
	var tween: Tween = create_tween()
	tween.connect("finished", _finish)
	tween.tween_property(self, "modulate:a", 1, _fade_time)
	tween.tween_interval(_time)
	tween.tween_property(self, "modulate:a", 0, _fade_time)


# Emite la señal "finished"
func _finish() -> void:
	emit_signal("finished")
	queue_free()
