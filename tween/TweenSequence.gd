tool
extends Node

export(Array, Resource) var tween_list setget set_tween_list

onready var tween = $Tween
export var repeat := false
export var add_implied_duration := true

func _ready():
	var target_node = self
	var duration_thus_far := 0.0
	var previous_final_value = null
	
	for t in tween_list:
		var i = null
		if t.initial_value_type == TweenData.InitialValueType.Explicit:
			i = t.initial_value()
		elif t.initial_value_type == TweenData.InitialValueType.PreviousFinal:
			i = previous_final_value
		tween.interpolate_property(target_node, t.property, i, t.final_value(), t.duration, t.transition, t.ease_type, duration_thus_far + t.delay)
		if add_implied_duration:
			duration_thus_far += t.delay + t.duration
		previous_final_value = t.final_value()

	if repeat:
		tween.repeat = true

	tween.start()
	
func set_tween_list(a):
	assert(a is Array)
	tween_list = a
	for i in range(tween_list.size()):
		if tween_list[i] == null:
			tween_list[i] = TweenData.new()
