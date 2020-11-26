extends Control
class_name ClickHolder

var mouse_left_down := false
var mouse_is_hovering := false

func _ready():
	connect("mouse_entered", self, "on_mouse_entered")
	connect("mouse_exited", self, "on_mouse_exited")

func on_mouse_entered():
	mouse_is_hovering = true

func on_mouse_exited():
	mouse_is_hovering = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			mouse_left_down = event.pressed
