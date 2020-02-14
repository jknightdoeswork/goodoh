extends Node

export var animation_name := ""
export var looping := false

func _ready():
	var p = get_parent()
	assert(p is AnimationPlayer)
	
	p.play(animation_name)
