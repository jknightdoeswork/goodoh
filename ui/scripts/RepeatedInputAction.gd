extends Node

signal action_triggered

export(String) var action_name

var next_press_time := 0.0
var trigger_times := [1.0, 0.5, 0.2, 0.1]
var trigger_count := 0

func _ready():
	if !InputMap.has_action(action_name):
		print_tree_pretty()
		printerr("[RepeatedInputAction] no action mapped with name: " + str(action_name))
	
func _process(delta):
	if Input.is_action_just_pressed(action_name):
		trigger_action()
	else:
		if Input.is_action_pressed(action_name):
			next_press_time -= delta
			if next_press_time <= 0.0:
				trigger_action()
		else:
			trigger_count = 0

func trigger_action():
	emit_signal("action_triggered")
	next_press_time = trigger_times[min(trigger_count, trigger_times.size()-1)]
	trigger_count += 1