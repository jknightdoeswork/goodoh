extends Node
class_name SetVisibilityListener
export var set_visibility_to = false

func do():
	get_parent().visible = set_visibility_to
