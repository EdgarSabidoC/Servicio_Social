@tool
extends TextureRect

## Allows to assign a SpriteFrame to animate the texture. Extends TextureRect.
class_name AnimatedTextureRect

## Sprites from SpriteFrames
@export var sprites: SpriteFrames
## Enums for the allowed animations
@export var current_animation: String = "default"
## Index of the current frame
@export var frame_index: int = 0
@export_range(0.0, INF, 0.001) var speed_scale: float = 1.0
## If true, allows to autoplay
@export var auto_play: bool = false
## If true, the animations is currently playing
@export var playing: bool = false
## Refresh rate of the animation (float)
@onready var refresh_rate: float = 1.0
## FPS of the animation (float)
@onready var fps: float = 30
## Delta frame (float)
@onready var frame_delta: float = 0
## If true, the sprite have changed
@onready var changed: bool = false

## Signal emitted when the animation finishes
signal finished
## Signal emitted when an animation changes
signal animation_changed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !sprites:
		return

	self.pivot_offset = self.size/2
	self.fps = self.sprites.get_animation_speed(self.current_animation)
	self.refresh_rate = self.sprites.get_frame_duration(self.current_animation, self.frame_index)
	if self.auto_play:
		self.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.changed:
		self.animation_changed.emit()
		self.changed = false
	if self.sprites == null or self.playing == false:
		return
	elif self.sprites.has_animation(self.current_animation) == false:
		self.playing = false
		assert(false, "Animation %s, does not exist" % self.current_animation)
	
	self.get_animation_data(self.current_animation)
	self.frame_delta += (self.speed_scale * delta)
	if self.frame_delta >= self.refresh_rate/self.fps:
		self.texture = self.get_next_frame()
		self.frame_delta = 0


# Reproduce la animación:
func play(animation: String = current_animation) -> void:
	self.frame_index = 0
	self.frame_delta = 0
	self.current_animation = animation
	self.get_animation_data(self.current_animation)
	self.playing = true


# Obtiene los datos de la animación:
func get_animation_data(animation: String) -> void:
	self.fps = self.sprites.get_animation_speed(animation)
	self.refresh_rate = self.sprites.get_frame_duration(animation, self.frame_index)


# Obtiene el siguiente frame de la animación:
func get_next_frame() -> Texture2D:
	# Se aumenta el índice de frames:
	self.frame_index += 1
	# Se obtiene la cuenta total de frames:
	var frame_count = self.sprites.get_frame_count(self.current_animation)
	# Se reincia el índice de los frames si se llega a un valor mayor o igual al total de frames:
	if self.frame_index >= frame_count:
		self.frame_index = 0 # Se reinicia
		if not self.sprites.get_animation_loop(self.current_animation):
			# Si no se está en un loop:
			self.playing = false
			self.frame_index = frame_count-1 # Se queda con el último frame.
			self.finished.emit()
	get_animation_data(self.current_animation)
	
	# Se retorna la siguiente textura de la animación:
	return self.sprites.get_frame_texture(self.current_animation, self.frame_index)


# Continúa con la animación si estaba pausada previamente:
func resume() -> void:
	self.playing = true


# Pausa la animación:
func pause() -> void:
	self.playing = false


# Para la animación:
func stop() -> void:
	self.frame_index = 0
	self.playing = false
