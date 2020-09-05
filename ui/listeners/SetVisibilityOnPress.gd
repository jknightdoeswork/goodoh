extends Node
class_name SetVisibilityOnPress

export(NodePath) var target
export var set_visible_to := true

onready var target_ = get_node(target) as CanvasItem
onready var parent := get_parent() as Button

func _ready():
	assert(parent != null)
	assert(target_ != null)
	parent.connect("pressed", self, "on_button_pressed")

func on_button_pressed():
	target_.visible = set_visible_to
