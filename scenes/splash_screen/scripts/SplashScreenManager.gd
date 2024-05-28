extends Control

@export var _move_to: PackedScene
@export var _initial_delay: float = 1

# Arreglo de SplashScreen, son los hijos de SplashScreenContainer:
var _splash_screens: Array[SplashScreen] = []

@onready var _splash_screen_container: CenterContainer = $SplashScreenContainer


func _ready() -> void:
	assert(_move_to)
	
	#Se cargan los valores de Audio del archivo de configuración:
	var master = Persistence.config.get_value("Audio", "0")
	AudioServer.set_bus_volume_db(0, linear_to_db(master))
	
	var music = Persistence.config.get_value("Audio", "1")
	AudioServer.set_bus_volume_db(1, linear_to_db(music))
	
	var sfx = Persistence.config.get_value("Audio", "2")
	AudioServer.set_bus_volume_db(0, linear_to_db(sfx))
	
	set_process_input(false)

	for splash_screen in _splash_screen_container.get_children():
		splash_screen.hide()
		_splash_screens.push_back(splash_screen)

	await get_tree().create_timer(_initial_delay).timeout

	_start_splash_screen()

	set_process_input(true)


# Lee los inputs que permiten saltar las escenas, llama a _skip():
func _input(_event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) \
	|| Input.is_key_pressed(KEY_SPACE) \
	|| Input.is_key_pressed(KEY_ESCAPE):
		_skip()


func _start_splash_screen() -> void:
	if _splash_screens.size() == 0:
		get_tree().change_scene_to_packed(_move_to)
	else:
		var splash_screen: SplashScreen = _splash_screens.pop_front()
		splash_screen.start()
		splash_screen.connect("finished", _start_splash_screen)


# Permite saltar las splash_screen:
func _skip() -> void:
	_splash_screen_container.get_child(0).queue_free()
	_start_splash_screen()
