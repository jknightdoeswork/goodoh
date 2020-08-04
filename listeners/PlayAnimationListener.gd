extends Node

export var animation_name := ""

func do():
	var p = get_parent()
	assert(p is AnimationPlayer)
	p.play(animation_name)
