extends CanvasLayer

@onready var animation_player_texture: AnimationPlayer = $TextureRect/AnimationPlayer
@onready var texture_rect: TextureRect = $TextureRect
@export var textures: Array[Texture2D]

# Función que permite hacer los cambios de escena:
func change_scene(target_scene: PackedScene, type: String = "dissolve", texture: int = 0) -> void:
	match type:
		"dissolve":
			transition_dissolve(target_scene, texture)


# Función que realiza un efecto de fundido (fade_in y fade_out):
func transition_dissolve(target_scene: PackedScene, texture: int = 0):
	texture_rect.texture = textures[texture]
	animation_player_texture.play("dissolve")
	await animation_player_texture.animation_finished
	get_tree().change_scene_to_packed(target_scene)
	animation_player_texture.play_backwards("dissolve")


# Función que realiza un efecto de fundido utilizando una silueta de zarigüeya:
func transition_oppusum(_target_scene: PackedScene, _texture: int = 0):
	pass
	
