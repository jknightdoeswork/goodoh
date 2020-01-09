extends Node

class_name RemoveNodeListener

func do():
	get_parent().queue_free()