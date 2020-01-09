extends Node

class_name StartParticlesOnReady

onready var parent = get_parent()

func _ready():
	assert(parent is Particles or parent is CPUParticles)
	parent.emitting = true
	