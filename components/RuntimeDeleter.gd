extends Node

class_name RemoveOnReady

export(bool) var pause:bool = true

func _ready() -> void:
	var parent = get_parent()
	assert(parent is Node)
	assert(parent.get_parent() is Node)
	yield(get_tree(), "idle_frame")
	parent.get_parent().remove_child(parent)
