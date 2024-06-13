extends TabBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Mouse.mouse_mode_activated:
		self.grab_focus()


func _on_tab_changed(tab: int) -> void:
	# Test debug:
	print_debug("Tab changed %s" % tab)


func _on_tab_button_pressed(tab: int) -> void:
	# Test debug:
	print_debug("Tab presed %s" % tab)


func _on_tab_selected(tab: int) -> void:
	# Test debug:
	print_debug("Tab selected %s" % tab)
