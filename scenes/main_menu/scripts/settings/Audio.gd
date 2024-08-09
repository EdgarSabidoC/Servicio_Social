extends TabBar

@onready var music: HSlider = %Music
@onready var master: HSlider = %Master
@onready var sfx: HSlider = %SFX
@onready var settings: TabContainer = %Settings
@onready var master_label: Label = $AudioOptionsContainer/HBoxContainer/AudioLabelsContainer/Master
@onready var music_label: Label = $AudioOptionsContainer/HBoxContainer/AudioLabelsContainer/Music
@onready var sfx_label: Label = $AudioOptionsContainer/HBoxContainer/AudioLabelsContainer/SFX


@onready var icons = ["🔇", "🔈", "🔉", "🔊"]
@onready var thresholds = [0, 0.25, 0.5, 1]


# Actualiza las etiquetas de cada slider:
func update_label(label: String, value: float) -> void:
	for i in range(thresholds.size()):
		if value <= thresholds[i]:
			var txt: String = icons[i] + " " + label
			match label:
				"Master":
					self.master_label.text = txt
				"Música":
					self.music_label.text = txt
				"Efectos especiales":
					self.sfx_label.text = txt
			break


# Para la señal Master: cambia el volumen para el index 0.
func _on_master_value_changed(value: float) -> void:
	if self.master_label:
		self.update_label("Master", value)
	set_volume(0, value)


# Para la señal Music: cambia el volumen para el index 1.
func _on_music_value_changed(value: float) -> void:
	if self.music_label:
		self.update_label("Música", value)
	set_volume(1, value)


# Para la señal SFX: cambia el volumen para el index 2.
func _on_sfx_value_changed(value: float) -> void:
	if self.sfx_label:
		self.update_label("Efectos especiales", value)
	set_volume(2, value)


# Ajusta el volumen de manera lineal por medio de DB (flotantes) y 
# guarda la configuración en la sección Audio:
func set_volume(idx: int, value: float) -> void:
	# linear_to_db necesita tener el rango de 0 a 1.
	# Por eso el volumen máximo es 1.
	AudioServer.set_bus_volume_db(idx, linear_to_db(value))
	Persistence.config.set_value("Audio", str(idx), value)
	Persistence.save_data()


func _on_visibility_changed() -> void:
	if self.is_visible_in_tree():
		self.update_label("Master", self.master.value)
		self.update_label("Música", self.music.value)
		self.update_label("Efectos especiales", self.sfx.value)
