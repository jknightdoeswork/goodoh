extends Node

export var animation_name := ""
export var looping := false
export var node_path := ""

func _ready():
	var p = get_node(node_path)
	assert(p is AnimationPlayer)
	var animation = p.get_animation(animation_name) as Animation
	if animation != null:
		print (animation.loop)
		animation.loop = looping
	p.play(animation_name)
