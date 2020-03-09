extends Node

export var property_name := ""
export(NodePath) var other_node
export var other_property_name := ""

func _ready():
	var parent = get_parent()
	var other = get_node(other_node)
	assert (parent != null)
	assert (other != null)
	
	var other_data = other.get(other_property_name)
	parent.set(other_property_name, other_data)
