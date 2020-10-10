extends Panel


var is_moving := false
var mouse_down_position := Vector2.ZERO
var movement_start_position := Vector2.ZERO
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed:
				if get_rect().has_point(event.position):
					is_moving = true
					mouse_down_position = event.position
					movement_start_position = rect_position
			else:
				is_moving = false
	if event is InputEventMouseMotion:
		if is_moving:
			var mouse_position :Vector2= event.position
			rect_position = movement_start_position + mouse_position - mouse_down_position
