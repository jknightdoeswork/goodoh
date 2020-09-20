extends Node
class_name MatchRectSize

onready var parent := get_parent() as Control
export(NodePath) var target_control
onready var target := get_node(target_control) as Control

func _ready():
	assert(target != null)
	assert(parent != null)
	target.connect("resized", self, "on_target_resized")

func on_target_resized():
	parent.rect_size = target.rect_size
	parent.rect_min_size = target.rect_size
