# Match Visibility
#  Component of a Control
#  Makes parent match target's visibility
#  Attaches to target's visiblity changed signal

extends Node

class_name MatchVisibility

export(NodePath) var target
export var invert := false

func _ready():
	# Connect to target's visibility_changed signal
	var parent = get_parent()
	assert(parent is Control)
	var target_node = get_node(target)
	
	if target_node is Control:
		target_node.connect("visibility_changed", self, "on_visibility_changed", [target_node])
	else:
		printerr("[MatchVisibility] target is not control.")
		print_tree_pretty()
		assert(false)
	
	# Set initial visibility	
	on_visibility_changed(target_node)
	
func on_visibility_changed(t):
	var parent = get_parent()
	assert(parent is Control)
	
	# Invert visible if needed
	var v:bool = t.visible
	if invert:
		v = !v
	
	# Apply visibility change
	parent.visible = v
	
func _exit_tree():
	# Disconnect signal
	var target_node = get_node(target)
	if target_node is Control:
		target_node.disconnect("visibility_changed", self, "on_visibility_changed")
