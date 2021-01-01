extends Node

# These must match in size
export(Array, NodePath) var tabs:Array
export(Array, NodePath) var panels:Array


func _ready():
	var tab_index := 0
	for tab_path in tabs:
		var tab := get_node(tab_path) as Button
		tab.connect("pressed", self, "on_tab_pressed", [tab_index])
		tab_index += 1
	
func on_tab_pressed(i:int):
	var panel_index := 0
	for panel_path in panels:
		var panel := get_node(panel_path) as Control
		panel.visible = panel_index == i
		panel_index += 1
