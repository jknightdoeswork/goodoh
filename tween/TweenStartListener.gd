tool
extends Node

onready var target_node = get_parent()
onready var tween = get_parent().get_node("Tween")

export(Resource) var tween_data
export var cancel_current_on_start := true
export var make_tween_data := false setget set_make_tween_data

func do():
	var t:TweenData = tween_data
	var i = null
	if t.initial_value_type == TweenData.InitialValueType.Explicit:
		i = t.initial_value()
	elif t.initial_value_type == TweenData.InitialValueType.PreviousFinal:
		pass
	tween.stop_all()
	tween.interpolate_property(target_node, t.property, i, t.final_value(), t.duration, t.transition, t.ease_type, t.delay)
	tween.start()
	
func set_make_tween_data(b:bool):
	if b:
		tween_data = TweenData.new()
		property_list_changed_notify()
