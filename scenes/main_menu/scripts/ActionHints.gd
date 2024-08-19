extends HBoxContainer

@onready var action_icon_1: ActionIcon = $UpActionHint/ActionIcon1
@onready var action_icon_2: ActionIcon = $DownActionHint/ActionIcon2
@onready var action_icon_3: ActionIcon = $LeftActionHint/ActionIcon3
@onready var action_icon_4: ActionIcon = $RightActionHint/ActionIcon4
@onready var action_icon_5: ActionIcon = $AcceptActionHint/ActionIcon5
@onready var action_icon_6: ActionIcon = $CancelActionHint/ActionIcon6
@onready var margin_container: MarginContainer = $"../MarginContainer"


func _ready() -> void:
	if !Mouse.mouse_mode_activated:
		self.show()
		self.margin_container.show()
	else:
		self.hide()
		self.margin_container.hide()
	self.action_icon_1.action_name = "ui_up"
	self.action_icon_2.action_name = "ui_down"
	self.action_icon_3.action_name = "ui_left"
	self.action_icon_4.action_name = "ui_right"
	self.action_icon_5.action_name = "ui_accept"
	self.action_icon_6.action_name = "ui_cancel"
	self.action_icon_1.refresh()
	self.action_icon_2.refresh()
	self.action_icon_3.refresh()
	self.action_icon_4.refresh()
	self.action_icon_5.refresh()
	self.action_icon_6.refresh()


func _process(_delta: float) -> void:
	if !Mouse.mouse_mode_activated:
		self.show()
		self.margin_container.show()
		self.action_icon_1.refresh()
		self.action_icon_2.refresh()
		self.action_icon_3.refresh()
		self.action_icon_4.refresh()
		self.action_icon_5.refresh()
		self.action_icon_6.refresh()
	else:
		self.hide()
		self.margin_container.hide()
