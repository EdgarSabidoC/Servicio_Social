extends CanvasItem

@export var _time_interval: float = 0.15
@export var _fade_time: float = 1

signal finished()


# Hace un fade in al fondo:
func fade_in() -> void:
	self.modulate.a = 0
	self.show()
	var tween: Tween = create_tween()
	tween.connect("finished", _finish)
	tween.tween_property(self, "modulate:a", 0, 0)
	tween.tween_interval(_time_interval)
	tween.tween_property(self, "modulate:a", 1, _fade_time)


# Hace un fade out al fondo:
func fade_out() -> void:
	modulate.a = 0
	self.show()
	var tween: Tween = create_tween()
	tween.connect("finished", _finish)
	tween.tween_property(self, "modulate:a", 1, 0)
	tween.tween_interval(_time_interval)
	tween.tween_property(self, "modulate:a", 0, _fade_time)


# Emite la señal "finished"
func _finish() -> void:
	emit_signal("finished")
