extends Spatial

class_name InterpolatedTransform

var last_physics_position 		:= Vector3(0,0,0)
var current_physics_position 	:= Vector3(0,0,0)

var last_physics_rotation		:= Quat.IDENTITY
var current_physics_rotation	:= Quat.IDENTITY

var last_physics_scale 			:= Vector3(0,0,0)
var current_physics_scale 		:= Vector3(0,0,0)

var parent:Spatial				= null

var interpolate_enabled 		:= true

func set_interpolate_enabled(enabled:bool):
	interpolate_enabled = enabled
	
func _ready():
	assert(get_parent() is Spatial)
	parent = get_parent()
	set_as_toplevel(true)
	interpolate_enabled = true

func _physics_process(_delta: float) -> void:
	last_physics_position = current_physics_position
	current_physics_position = parent.translation
	
	last_physics_rotation = current_physics_rotation
	current_physics_rotation.set_euler(parent.rotation)

	last_physics_scale = current_physics_scale
	current_physics_scale = parent.scale
		
func _process(_delta: float) -> void:
	if interpolate_enabled:
		#var interpolation_factor = InterpolationMaster.interpolation_factor
		var interpolation_factor = Engine.get_physics_interpolation_fraction()
		translation = lerp(last_physics_position, current_physics_position, interpolation_factor)
		rotation = last_physics_rotation.slerp(current_physics_rotation, interpolation_factor).get_euler()
		scale = lerp(last_physics_scale, current_physics_scale, interpolation_factor)
	else:
		translation = current_physics_position
		rotation = current_physics_rotation.get_euler()
		scale = current_physics_scale
			
