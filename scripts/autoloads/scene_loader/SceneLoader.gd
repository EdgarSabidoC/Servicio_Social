extends Node

@onready var loading_screen_scene: PackedScene = preload("res://components/loading_screen/LoadingScreen.tscn")
@onready var scene_to_load_path: String
var loading_screen_scene_instance: Node
var loading: bool = false


func load_scene(path: String) -> void:
	var current_scene = get_tree().current_scene # Escena actual
	
	# Se instancia una escena de carga:
	loading_screen_scene_instance = loading_screen_scene.instantiate()
	get_tree().root.call_deferred("add_child", loading_screen_scene_instance)
	
	# Caché:
	if ResourceLoader.has_cached(path):
		ResourceLoader.load_threaded_get(path)
	else:
		ResourceLoader.load_threaded_request(path)
	
	# Se libera la escena actual:
	current_scene.queue_free()
	
	# Se activa la carga:
	loading = true
	scene_to_load_path = path
	

func _process(_delta: float) -> void:
	if not loading:
		return
	
	var progress: Array = []
	var status = ResourceLoader.load_threaded_get_status(scene_to_load_path, progress)
	
	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		var progress_bar = loading_screen_scene_instance.get_node("ProgressBar")
		progress_bar.value = progress[0]*100
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		SceneTransition.change_scene(ResourceLoader.load_threaded_get(scene_to_load_path))
		loading_screen_scene_instance.queue_free()
		loading = false
	else:
		print_debug("Loading went wrong...")
		return
	
	
