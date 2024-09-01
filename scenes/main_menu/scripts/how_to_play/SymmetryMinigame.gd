extends TabBar

@onready var action_icon: ActionIcon
# Navegación:
@onready var up_image_path: String
@onready var down_image_path: String
@onready var left_image_path: String
@onready var right_image_path: String
# Mouse:
@onready var left_click_image_path: String
@onready var right_click_image_path: String

# Tamaños de teclas de navegación:
@export var up_width: float = 0
@export var up_height: float = 80
@export var down_width: float = 0
@export var down_height: float = 80
@export var left_width: float = 0
@export var left_height: float = 80
@export var right_width: float = 0
@export var right_height: float = 80
# Tamaño de botones de mouse:
@export var left_click_width: float = 0
@export var left_click_height: float = 60
@export var right_click_width: float = 0
@export var right_click_height: float = 60


func load_data() -> void:
	# Se crea el ActionIcon:
	action_icon = ActionIcon.new()
	# Se asginan las acciones a los ActionIcon:
	action_icon.action_name = "ui_up"
	up_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	action_icon.action_name = "ui_down"
	down_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	action_icon.action_name = "ui_left"
	left_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	action_icon.action_name = "ui_right"
	right_image_path = action_icon._get_keyboard(Mouse.input_actions[action_icon.action_name][0].keycode).get_path()
	left_click_image_path = action_icon._get_mouse(MOUSE_BUTTON_LEFT).get_path()
	right_click_image_path = action_icon._get_mouse(MOUSE_BUTTON_RIGHT).get_path()
	# Se carga la información desde el archivo:
	up_image_path = "[center]«[img={up_width}x{up_height}]{up_image}[/img]» ".format({"up_width": 0, "up_height": 40, "up_image": up_image_path})
	down_image_path = "«[img={down_width}x{down_height}]{down_image}[/img]» ".format({"down_width": 0, "down_height": 40, "down_image": down_image_path})
	left_image_path = "«[img={left_width}x{left_height}]{left_image}[/img]» ".format({"left_width": 0, "left_height": 40, "left_image": left_image_path})
	right_image_path = "«[img={right_width}x{right_height}]{right_image}[/img]»[/center]".format({"right_width": 0, "right_height": 40, "right_image": right_image_path})
	left_click_image_path = "«[img={left_click_width}x{left_click_height}]{left_click_image}[/img]» ".format({"left_click_width": 0, "left_click_height": 40, "left_click_image": left_click_image_path})
	right_click_image_path = "«[img={right_click_width}x{right_click_height}]{right_click_image}[/img]» ".format({"right_click_width": 0, "right_click_height": 40, "right_click_image": right_click_image_path})


func clear_data() -> void:
	action_icon.queue_free()
	up_image_path = ""
	down_image_path = ""
	left_image_path = ""
	right_image_path = ""
	left_click_image_path = ""
	right_click_image_path = ""


func _on_visibility_changed() -> void:
	if is_visible():
		load_data()
		$ScrollbarTextbox.print_text(up_image_path+down_image_path+left_image_path+right_image_path+left_click_image_path+right_click_image_path)
		return
	clear_data()
