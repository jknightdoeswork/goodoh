extends Node

class_name SetAsTopLevel

func _ready():
	assert(get_parent() is Spatial)
	get_parent().set_as_toplevel(true)
