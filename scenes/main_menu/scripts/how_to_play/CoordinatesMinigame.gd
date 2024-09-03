extends TabBar

@onready var _str: String = ""
@onready var action_icon: ActionIcon
# Pausa:
@onready var pause_image_path: String
# Mouse:
@onready var left_click_image_path: String

func load_data() -> void:
	# Se crea el ActionIcon:
	action_icon = ActionIcon.new()
	# Se asginan las acciones a los ActionIcon:
	# Teclado:
	action_icon.action_name = "ui_pause"
	pause_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	# Mouse:
	left_click_image_path = action_icon._get_mouse(MOUSE_BUTTON_LEFT).get_path()
	# Se carga la información desde el archivo:
	# Clicks del mouse:
	_str += "\n\nAcciones del mouse:\n"
	left_click_image_path = "Seleccionar/Mantener: [img={left_click_width}x{left_click_height}]{left_click_image}[/img]\n".format({"left_click_width": 0, "left_click_height": 60, "left_click_image": left_click_image_path})
	_str += left_click_image_path
	# Pausa:
	pause_image_path = "[img={pause_width}x{pause_height}]{pause_image}[/img]\n".format({"pause_width": 80, "pause_height": 60, "pause_image": pause_image_path})
	_str += "\n\nMenú de pausa: "
	_str += pause_image_path


func clear_data() -> void:
	action_icon.queue_free()
	_str = ""
	pause_image_path = ""
	left_click_image_path = ""


func _on_visibility_changed() -> void:
	if is_visible():
		load_data()
		$ScrollbarTextbox.print_text(_str)
		return
	clear_data()
