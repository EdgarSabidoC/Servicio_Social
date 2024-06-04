extends Control

const LEVEL = preload("res://components/level/Level.tscn")

func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ENTER):
		# Moverse a la siguiente escena:
		#get_tree().change_scene_to_file("res://scenes/levels/level_01/Level01.tscn")
		#get_tree().change_scene_to_packed(LEVEL)
		CharactersData.loadProblemsData()
		var level = LEVEL.instantiate()
		get_tree().root.add_child(level)
		set_process(false)
