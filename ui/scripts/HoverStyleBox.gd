extends Node

export(String) var style_name := "normal"
export(StyleBox) var normal_stylebox
export(StyleBox) var hover_stylebox

onready var parent_control := get_parent() as Control

func _ready():
	parent_control.connect("mouse_entered", self, "on_mouse_entered")
	parent_control.connect("mouse_exited", self, "on_mouse_exited")

func on_mouse_entered():
	parent_control.add_stylebox_override(style_name, hover_stylebox)

func on_mouse_exited():
	parent_control.add_stylebox_override(style_name, normal_stylebox)
