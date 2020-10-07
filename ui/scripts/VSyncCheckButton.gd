extends Node

class_name VSyncCheckButton

func _ready() -> void:
	var parent = get_parent()
	assert (parent is CheckButton)
	
	# Connect signal
	var error = parent.connect("toggled", self, "on_toggle")
	assert(!error)

func on_toggle(toggled):
	OS.vsync_enabled = toggled
	OS.vsync_via_compositor = toggled
