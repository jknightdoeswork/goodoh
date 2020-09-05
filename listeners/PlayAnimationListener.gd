extends Node

export var animation_name := ""

func do():
	var p :AnimationPlayer= get_parent()
	assert(p != null)
	p.play(animation_name)
