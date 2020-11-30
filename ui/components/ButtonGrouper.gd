extends Node
class_name ButtonGrouper

signal changed

onready var parent_control := get_parent() as Control
onready var button_group := ButtonGroup.new()
onready var buttons := []
var selected:int

func _ready():
	for i in parent_control.get_children():
		if i is Button:
			var b := i as Button
			b.group = button_group
			b.connect("pressed", self, "button_pressed")
			buttons.append(b)
	button_pressed()

func button_pressed():
	selected = buttons.find(button_group.get_pressed_button())
	self.emit_signal("changed")
