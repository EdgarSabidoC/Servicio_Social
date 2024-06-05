extends Node

@onready var mouse_mode_activated: bool = false

func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass

func change_mode() -> void:
	mouse_mode_activated = !mouse_mode_activated
	if mouse_mode_activated:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#if Input.is_action_just_pressed("ui_up") or \
	#Input.is_action_just_pressed("ui_down") or \
	#Input.is_action_just_pressed("ui_right") or \
	#Input.is_action_just_pressed("ui_left") or \
	#Input.is_action_just_pressed("ui_accept") or \
	#Input.is_action_just_pressed("ui_cancel"):
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#elif event is InputEventMouseMotion:
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
