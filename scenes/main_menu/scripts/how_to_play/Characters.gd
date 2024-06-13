extends TabBar

@onready var actual_tab: int = 0
@onready var actual_icon: Texture2D
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var label: Label = $VBoxContainer/Label

signal pressed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	v_box_container.hide()
	if !Mouse.mouse_mode_activated:
		self.grab_focus()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		pressed.emit()


func _on_tab_changed(tab: int) -> void:
	# Test debug:
	print_debug("Tab changed %s" % tab)


func _on_tab_selected(tab: int) -> void:
	# Test debug:
	print_debug("Tab selected %s" % tab)
	actual_tab = tab


func _on_tab_clicked(tab: int) -> void:
	# Test debug:
	print_debug("Tab clicked %s" % tab)


func _on_pressed() -> void:
	# Test debug:
	print_debug("Tab pressed %s" % actual_tab)
	for tab in tab_count:
		if actual_tab != tab:
			set_tab_hidden(tab, true)
	v_box_container.show()
