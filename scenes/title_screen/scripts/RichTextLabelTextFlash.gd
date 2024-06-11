@tool
extends RichTextLabel
class_name RichTextLabelTextFlash

#*******************************************************************************/
#--------------------------------Flashing Text--------------------------------*/
#*******************************************************************************/
# This is a script created to make your text flash
# You'll have that old "Insert Coin" vibe
#********************************************************************HELP DOWN */

#-----------------------------Exporting variables-----------------------------*/
@export var speed: float = 5
@export var numberOfFlashes: int = 0
@export var delay: float = 0
@export var fade: bool
@export var preview: bool = false
@export var start: bool = false
@onready var accept_texture: ActionIcon = $"../ActionIcon"
@onready var pause_texture: ActionIcon = $"../ActionIcon2"
@onready var accept_texture_path: String = "res://addons/ActionIcon/Keyboard/Enter.png"
@onready var pause_texture_path: String = "res://addons/ActionIcon/Keyboard/Space.png"
@onready var accept: ActionIcon = ActionIcon.new()
@onready var pause: ActionIcon =  ActionIcon.new()
@export var accept_width: float = 0
@export var accept_height: float = 65
@export var pause_width: float = 0
@export var pause_height: float = 90

#----------------------------Not Exported variables----------------------------*/
var time = 0.0
var timeSin = 0
var myActualFlash = 0
var sinCycle = 0
var _visible = true


#--------------------------------Initializing --------------------------------*/
func _ready():
	time = 0
	accept.action_name = "ui_accept"
	pause.action_name = "ui_pause"
	# Se obtienen las imágenes de las acciones:
	accept_texture_path = accept._get_keyboard(Mouse.input_actions["ui_accept"][0].keycode).get_path()
	pause_texture_path = pause._get_keyboard(Mouse.input_actions["ui_pause"][0].keycode).get_path()
	self.text = "[center]Presiona [img={accept_width}x{accept_height}]{accept}[/img] o presiona [img={pause_width}x{pause_height}]{pause}[/img] para continuar[/center]".format({"accept_width": str(accept_width), "accept_height": str(accept_height), "accept": accept_texture_path, "pause_width": str(pause_width), "pause_height": str(pause_height), "pause": pause_texture_path})
	# Se cambia el tamaño de la fuente a 22px:
	self.add_theme_font_size_override("normal_font_size", 22)
	accept.refresh()
	pause.refresh()


#-----------------------------Making things happen-----------------------------*/
func _process(delta):
	if Engine.is_editor_hint():
		if preview:
			time += delta
			timeSin = sin(time*speed)
			if start:
				_start()
				start = false
			flashMyText()

		else:
			visible = true
			_visible = true
	if not Engine.is_editor_hint():
		time += delta
		timeSin = sin(time*speed)
		flashMyText()

#*******************************************************************************/
#-----------------------------------Flashing-----------------------------------*/
#*******************************************************************************/


#-------Start() func initializes the real flash in case it's not looping-------*/
#------User can call start() and eventually give parameters for the flash------*/

func _start(numberOfFlashess:int = 0,speedd:int = 0,fadee:bool = false):
	if numberOfFlashess == 0 and speedd == 0 and !fadee:
		time = 0 
		_visible = true
		visible = true
		myActualFlash = numberOfFlashes
		modulate.a = 1 
	else:
		time = 0 
		numberOfFlashes = numberOfFlashess
		speed = speedd
		fade = fadee
		_visible = true
		visible = true
		myActualFlash = numberOfFlashes
		modulate.a = 1 


#-----------------------------Here comes the magic-----------------------------*/
func flashMyText():
#-----------------------We check if there a delay time -----------------------*/
	if delay < time:
		if myActualFlash > 0 and numberOfFlashes > 0:
			if !fade:
				if timeSin > 0:
					_visible = true
					if sinCycle == 0:
						sinCycle = 1
				else:
					_visible = false
					if sinCycle == 1:
						sinCycle = 2
				visible = _visible
			else:
				if timeSin > 0:
					if sinCycle == 0:
						sinCycle = 1
				else:
					if sinCycle == 1:
						sinCycle = 2
				modulate.a = timeSin
#------------------Checking if an entair cycle has been done------------------*/
#----------------------This way we keep track of the n of----------------------*/
			if sinCycle == 2 :
				myActualFlash -= 1
				sinCycle = 0
#--------------------------------Looping Flash--------------------------------*/
		if numberOfFlashes == 0:
			if !fade:
				modulate.a = 1
				if timeSin > 0:
					_visible = true
				else:
					_visible = false
				visible = _visible
			else:
				modulate.a = timeSin


#*******************************************************************************/
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>HELP<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/
#*******************************************************************************/
#-----------------------------PARAMETERS TO TWEAK-----------------------------*/

#------------------------------NUMBER OF FLASHES------------------------------*/
# You can set the "numberOfFlashes" in order to define how many times it will flash
# Set numberOfFlashes to 0 to make it loop

#------------------------------------SPEED------------------------------------*/
# Speed is by deafoult 5 increasing it means it will flash faster

#------------------------------------DELAY------------------------------------*/
# By deafoult 0
# It will determin how many seconds od delay will be before the flashing happens

#-------------------------------------FADE-------------------------------------*/
# Makes the text fade instead of turning on of

#------------------------------Preview on editor------------------------------*/
# If you want to preview it on editor just check the preview option
# It may request a scene reload to work
# If the "numberOfFlashes" is greater than 0 you need to call start() so....
# Click on the start check box to test it 
#*******************************************************************************/
