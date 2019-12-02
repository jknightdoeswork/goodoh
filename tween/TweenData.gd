tool
extends Resource
class_name TweenData

export(String) var property
export(Array) var values
export var duration 	:= 1.0
export var delay 		:= 1.0

"""
Note this TT enum is a duplicate of Tween.TransitionType
"""
enum TT {Linear, Sine, Quint, Quart, Quad, Expo, Elastic, Cubic, Circ, Bounce, Back}
export (TT) var transition = Tween.TRANS_LINEAR

"""
Note this ET enum is a duplicate of Tween.EaseType
"""
enum ET {In, Out, InOut, OutIn}
export(ET) var ease_type 	:= Tween.EASE_IN

enum InitialValueType {Explicit, Null, PreviousFinal}
export (InitialValueType) var initial_value_type = InitialValueType.Explicit

func initial_value():
	return values[0]
	
func final_value():
	return values[1]

func _init():
	if values.size() != 2:
		values.resize(2)
	
	._init()
