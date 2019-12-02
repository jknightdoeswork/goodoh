extends Node

class_name GrabFocusOnVisible

var parent:Control

func _ready():
	assert (get_parent() is Control)
	parent = get_parent()
	
	var e = parent.connect("visibility_changed", self, "do") 
	assert(e == 0)
	
func do():
	if (parent.is_visible_in_tree()):
		print ("grabbing focus")
		parent.grab_focus()
