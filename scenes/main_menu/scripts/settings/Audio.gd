extends TabBar

@onready var master = %Master
@onready var settings = %Settings


# Para la señal Master: cambia el volumen para el index 0.
func _on_master_value_changed(value: float) -> void:
	set_volume(0, value)


# Para la señal Music: cambia el volumen para el index 1.
func _on_music_value_changed(value: float) -> void:
	set_volume(1, value)


# Para la señal SFX: cambia el volumen para el index 2.
func _on_sfx_value_changed(value: float) -> void:
	set_volume(2, value)


# Ajusta el volumen de manera lineal por medio de DB (flotantes) y 
# guarda la configuración en la sección Audio:
func set_volume(idx: int, value: float) -> void:
	# linear_to_db necesita tener el rango de 0 a 1.
	# Por eso el volumen máximo es 1.
	AudioServer.set_bus_volume_db(idx, linear_to_db(value))
	Persistence.config.set_value("Audio", str(idx), value)
	Persistence.save_data()
