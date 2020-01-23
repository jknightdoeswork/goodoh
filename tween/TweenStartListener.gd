tool
extends Node

onready var target_node = get_parent()
onready var tween = get_parent().get_node("Tween")

export(Resource) var tween_data
export var make_tween_data := false setget set_make_tween_data

func do():
	var t:TweenData = tween_data
	var i = null
	if t.initial_value_type == TweenData.InitialValueType.Explicit:
		i = t.initial_value()
	elif t.initial_value_type == TweenData.InitialValueType.PreviousFinal:
		pass
	tween.interpolate_property(target_node, t.property, i, t.final_value(), t.duration, t.transition, t.ease_type, t.delay)

func set_make_tween_data(b:bool):
	print (b)
	if b:
		tween_data = TweenData.new()
		property_list_changed_notify()