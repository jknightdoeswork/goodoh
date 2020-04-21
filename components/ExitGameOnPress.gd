extends Node

func _ready():
	var parent = get_parent()
	assert(parent is Button)
	parent.connect("pressed", self, "on_button_pressed")


func on_button_pressed():
	print ("[ExitGameOnPress] quitting")
	get_tree().quit()
