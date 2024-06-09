extends CanvasLayer

@onready var animation_player_texture: AnimationPlayer = $TextureRect/AnimationPlayer
@onready var texture_rect: TextureRect = $TextureRect


# Función que permite hacer los cambios de escena:
func change_scene(target_scene: PackedScene, type: String) -> void:
	match type:
		"dissolve":
			transition_dissolve(target_scene)
	

# Función que realiza un efecto de fundido (fade_in y fade_out):
func transition_dissolve(target_scene: PackedScene):
	texture_rect.texture = ResourceLoader.load("res://assets/graphical_assets/parallax/sky.tga")
	animation_player_texture.play("dissolve")
	await animation_player_texture.animation_finished
	get_tree().change_scene_to_packed(target_scene)
	animation_player_texture.play_backwards("dissolve")


# Función que realiza un efecto de fundido utilizando una silueta de zarigüeya:
func transition_oppusum(_target_scene: PackedScene):
	pass
	
