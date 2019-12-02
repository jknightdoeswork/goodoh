extends Node

signal on_value_changed

export(String) var file_name := "settings.ini"

var config_file:ConfigFile = null

func _enter_tree() -> void:
	config_file = ConfigFile.new()
	var path := file_path()
	var config_file_object := File.new()
	if config_file_object.file_exists(path):
		print ("[Settings] loading config file at path: " + path + " using directory: " + OS.get_user_data_dir())
		var load_error = config_file.load(path)
		if load_error != 0:
			printerr ("[Settings] error " + str(load_error) + " loading config file at path: " + path)
			assert(false)
	else:
		print ("[Settings] no config file found at path: " + path)
	
func _exit_tree() -> void:
	print ("[Settings] exit_tree")
	
func get_value(k:String, default_value=null):
	return config_file.get_value("main", k, default_value)
	
func set_value(k:String, v):
	config_file.set_value("main",k, v)
	emit_signal("on_value_changed", k, v)
	# TODO
	# Profile and optimize this!
	var save_error = config_file.save(file_path())
	if (save_error != 0):
		printerr ("[Settings] save error " + str(save_error))
		assert(false)
		
func has_value(k:String):
	return get_value(k) != null
	
func set_default_value(k:String, v):
	var value = get_value(k)
	if value == null:
		set_value(k, v)
		return v
	return value
	
func file_path() -> String:
	return "user://" + file_name
