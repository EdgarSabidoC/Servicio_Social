extends VBoxContainer
@onready var master = %Master
@onready var music = %Music
@onready var sfx = %SFX

func _ready() -> void:
	# Se cargan los valores del archivo de configuración para el valor de los sliders:
	master.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	music.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	sfx.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	
