extends HBoxContainer

@onready var action_icon_1: ActionIcon = $UpActionHint/ActionIcon1
@onready var action_icon_2: ActionIcon = $DownActionHint/ActionIcon2
@onready var action_icon_3: ActionIcon = $LeftActionHint/ActionIcon3
@onready var action_icon_4: ActionIcon = $RightActionHint/ActionIcon4
@onready var action_icon_5: ActionIcon = $AcceptActionHint/ActionIcon5
@onready var action_icon_6: ActionIcon = $CancelActionHint/ActionIcon6


func _ready() -> void:
	if !Mouse.mouse_mode_activated:
		self.show()
	else:
		self.hide()
	action_icon_1.action_name = "ui_up"
	action_icon_2.action_name = "ui_down"
	action_icon_3.action_name = "ui_left"
	action_icon_4.action_name = "ui_right"
	action_icon_5.action_name = "ui_accept"
	action_icon_6.action_name = "ui_cancel"
	action_icon_1.refresh()
	action_icon_2.refresh()
	action_icon_3.refresh()
	action_icon_4.refresh()
	action_icon_5.refresh()
	action_icon_6.refresh()


func _process(_delta: float) -> void:
	if !Mouse.mouse_mode_activated:
		self.show()
		action_icon_1.refresh()
		action_icon_2.refresh()
		action_icon_3.refresh()
		action_icon_4.refresh()
		action_icon_5.refresh()
		action_icon_6.refresh()
	else:
		self.hide()
