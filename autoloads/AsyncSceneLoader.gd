extends Node

signal scene_loaded

var thread:Thread
var semaphore:Semaphore
var mutex:Mutex

# Read & Write access must be guarded by mutex
var loading_queue := []
var loaded_levels := {}

const verbose := true

func thread_update(_u):
	while true:
		semaphore.wait()
		verbose_print("[AsyncSceneLoader] awoken")
		mutex.lock()
		if loading_queue.size() == 0:
			mutex.unlock()
			verbose_print("[AsyncSceneLoader] nothing to load")
		else:
			var scene_path:String = loading_queue.pop_front()
			mutex.unlock()
			
			verbose_print("[AsyncSceneLoader] loading " + scene_path)
			var scene := ResourceLoader.load(scene_path) as PackedScene
			var level := scene.instance()
			
			mutex.lock()
			loaded_levels[scene_path] = level
			mutex.unlock()
			
			call_deferred("send_signal", scene_path)
		

func _ready():
	mutex = Mutex.new()
	semaphore = Semaphore.new()
	thread = Thread.new()
	thread.start(self, "thread_update")

func enqueue_scene_load(path:String):
	mutex.lock()
	loading_queue.append(path)
	mutex.unlock()
	# Make sure callers have a frame to connect to signal
	call_deferred("awaken_semaphore")

func get_cached_scene(path:String)->Node:
	var to_return:Node = null
	mutex.lock()
	if loaded_levels.has(path):
		to_return = loaded_levels[path]
	mutex.unlock()
	return to_return

func send_signal(path:String):
	verbose_print("[AsyncSceneLoader] scene_loaded " + str(path))
	emit_signal("scene_loaded", path)

func awaken_semaphore():
	semaphore.post()

func verbose_print(s:String):
	if verbose:
		print(s)
		

