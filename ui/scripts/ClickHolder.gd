extends Control
class_name ClickHolder

var mouse_left_down := false
var mouse_left_last := false
var mouse_left_up := false
var mouse_left := false
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
			mouse_left = event.pressed

func _process(delta):
	mouse_left_down = mouse_left and not mouse_left_last
	mouse_left_up = not mouse_left and mouse_left_last
	
	mouse_left_last = mouse_left
