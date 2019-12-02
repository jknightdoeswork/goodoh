tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("TweenData", 		"Resource", load("res://addons/OOTween/TweenData.gd"), null)

func _exit_tree():
	remove_custom_type("TweenData")
