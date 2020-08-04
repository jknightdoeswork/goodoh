extends Node

onready var parent = get_parent()

func do():
	assert(parent is Particles)
	parent.emitting = true
	
