extends Node

class_name FollowTransform

export var follow_smooth_time := 0.5
export var offset := Vector3.ZERO

var parent:Spatial = null
var grandparent:Spatial = null
var velocity := Vector3.ZERO
var target_location := Vector3.ZERO
var follow_enabled := true

func _ready() -> void:
	assert(get_parent() is Spatial)
	assert(get_parent().get_parent() is Spatial)
	parent = get_parent()
	grandparent = parent.get_parent()
	parent.set_as_toplevel(true)
	target_location = parent.to_global(Vector3.ZERO)
	
func _process(delta: float) -> void:
	if follow_enabled:
		target_location = grandparent.to_global(Vector3.ZERO) + offset
	parent.translation = Smoothing.smooth_damp_vec3(parent.translation, target_location, velocity, follow_smooth_time, delta, INF)
	velocity = Smoothing.smooth_damp_vec3_velocity
