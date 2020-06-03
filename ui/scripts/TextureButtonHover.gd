extends TextureButton

class_name TextureButtonHover

export var normal_color := Color.transparent
export var hover_color := Color(1.0, 1.0, 1.0, 32.0/255.0)
export var pressed_color := Color(1.0, 1.0, 1.0, 64.0/255.0)
export var use_self_modulate := true

var is_hovered := false
var is_pressed := false

func _ready():
	connect("mouse_entered", self, "on_mouse_entered")
	connect("mouse_exited", self, "on_mouse_exited")
	connect("button_down", self, "on_button_down")
	connect("button_up", self, "on_button_up")
	set_color()

# Hover
func on_mouse_entered():
	is_hovered = true
	set_color()
func on_mouse_exited():
	is_hovered = false
	set_color()

# Pressed
func on_button_down():
	is_pressed = true
	set_color()
func on_button_up():
	is_pressed = false
	set_color()

func set_color():
	if is_pressed:
		set_color_(pressed_color)
	elif is_hovered:
		set_color_(hover_color)
	else:
		set_color_(normal_color)

func set_color_(color:Color):
	if use_self_modulate:
		self.self_modulate = color
	else:
		self.modulate = color
