extends Control

@export var _move_to: PackedScene
@export var _initial_delay: float = 1

# Arreglo de SplashScreen, son los hijos de SplashScreenContainer:
var _splash_screens: Array[SplashScreen] = []

@onready var _splash_screen_container: CenterContainer = $SplashScreenContainer
@onready var _first_splash_screen: bool = true

func _enter_tree() -> void:
	DisplayServer.window_set_current_screen(DisplayServer.get_primary_screen())
	# Se centra la ventana del juego:
	get_window().move_to_center()
	# Hack para que se mantenga el focus del SO:
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)


func _ready() -> void:
	assert(_move_to)
	
	set_process_input(false)

	for splash_screen in _splash_screen_container.get_children():
		splash_screen.hide()
		_splash_screens.push_back(splash_screen)

	await get_tree().create_timer(_initial_delay).timeout

	_start_splash_screen()

	set_process_input(true)


func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


# Lee los inputs que permiten saltar las escenas, llama a _skip():
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("m1") \
	or Input.is_action_just_pressed("ui_accept") \
	or Input.is_action_just_pressed("ui_pause"):
		_skip()


func _start_splash_screen() -> void:
	if _splash_screens.size() == 0:
		get_tree().change_scene_to_packed(_move_to)
	else:
		if _first_splash_screen:
			Sfx.play_sound(Sfx.Sounds.SPLASH_SCREEN)
			_first_splash_screen = false
		var splash_screen: SplashScreen = _splash_screens.pop_front()
		splash_screen.start()
		splash_screen.connect("finished", _start_splash_screen)


# Permite saltar las splash_screen:
func _skip() -> void:
	_splash_screen_container.get_child(0).queue_free()
	_start_splash_screen()
