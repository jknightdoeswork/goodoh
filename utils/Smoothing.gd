extends Node

##
## Smooth Damp
##
func smooth_damp(current:float, target:float, velocity:float, smooth_time:float, delta_time = 1.0, max_speed:float = INF) -> Vector2:
	"""
	smoothly damps between current and target without overshoot. returns (output, new_velocity).
	"""
	delta_time = max(0.00001, delta_time)
	smooth_time = max(0.0001, smooth_time)
	var omega:float = 2.0 / smooth_time
	
	var x = omega * delta_time
	var expo = 1.0 / (1.0 + x + 0.48 * x * x + 0.235 * x * x * x)
	var change = current - target
	var original_to = target
	
	var max_change = max_speed * smooth_time
	change = clamp(change, -max_change, max_change)
	target = current - change
	
	var temp = (velocity + omega * change) * delta_time
	velocity = (velocity - omega * temp) * expo
	var output = target + (change + temp) * expo
	
	if ((original_to - current > 0.0) == (output > original_to)):
		output = original_to
		velocity = (output - original_to) / delta_time
		
	return Vector2(output, velocity)
	
func smooth_damp_angle(current:float, target:float, velocity:float, smooth_time:float, delta_time = 1.0, max_speed:float = INF):
	"""
	smoothly damps between current and target while always using the shortest angle between. returns (output, new_velocity).
	"""
	target = current + delta_angle(current, target)
	return smooth_damp(current, target, velocity, smooth_time, delta_time, max_speed)

func delta_angle(current:float, target:float) -> float:
	var delta = fposmod((target - current), PI * 2.0)
	if (delta > PI):
		delta = delta - PI * 2.0
	return delta

var smooth_damp_vec3_velocity := Vector3.ZERO
func smooth_damp_vec3(current:Vector3, target:Vector3, velocity:Vector3, smooth_time:float, delta_time:float, max_speed:float = INF) -> Vector3:
	"""
	"""
	var output_x := 0.0
	var output_y := 0.0
	var output_z := 0.0
	smooth_time = max(0.0001, smooth_time)
	var omega := 2.0 / smooth_time
	var x = omega * delta_time
	var expo = 1.0 / (1.0 + x + 0.48 * x * x + 0.235 * x * x * x)	
	
	var change_x = current.x - target.x
	var change_y = current.y - target.y
	var change_z = current.z - target.z
	
	var original_to = target
	var max_change = max_speed * smooth_time
	var max_change_sq = max_change * max_change
	var sqrmag = change_x * change_x + change_y * change_y + change_z * change_z
	
	if sqrmag > max_change_sq:
		var mag = sqrt(sqrmag)
		change_x = change_x / mag * max_change
		change_y = change_y / mag * max_change
		change_z = change_z / mag * max_change
	
	target.x = current.x - change_x
	target.y = current.y - change_y
	target.z = current.z - change_z
	
	var temp_x = (velocity.x + omega * change_x) * delta_time
	var temp_y = (velocity.y + omega * change_y) * delta_time
	var temp_z = (velocity.z + omega * change_z) * delta_time
	
	velocity.x = (velocity.x - omega * temp_x) * expo
	velocity.y = (velocity.y - omega * temp_y) * expo
	velocity.z = (velocity.z - omega * temp_z) * expo
	
	output_x = target.x + (change_x + temp_x) * expo
	output_y = target.y + (change_y + temp_y) * expo
	output_z = target.z + (change_z + temp_z) * expo
	
	var orig_minus_current_x = original_to.x - current.x
	var orig_minus_current_y = original_to.y - current.y
	var orig_minus_current_z = original_to.z - current.z
	var out_minus_origin_x = output_x - original_to.x
	var out_minus_origin_y = output_y - original_to.y
	var out_minus_origin_z = output_z - original_to.z
	
	if orig_minus_current_x * out_minus_origin_x + orig_minus_current_y * out_minus_origin_y + orig_minus_current_z * out_minus_origin_z > 0:
		output_x = original_to.x
		output_y = original_to.y
		output_z = original_to.z
		
		velocity.x = (output_x - original_to.x) / delta_time
		velocity.y = (output_y - original_to.y) / delta_time
		velocity.z = (output_z - original_to.z) / delta_time
		
	smooth_damp_vec3_velocity = velocity
	return Vector3(output_x, output_y, output_z)

func smooth_damp_vec3_angle(current:Vector3, target:Vector3, velocity:Vector3, smooth_time:float, delta_time:float, max_speed:float = INF) -> Vector3:
	"""
	"""
	target.x = current.x + delta_angle(current.x, target.x)
	target.y = current.y + delta_angle(current.y, target.y)
	target.z = current.z + delta_angle(current.z, target.z)
	
	return smooth_damp_vec3(current, target, velocity, smooth_time, delta_time, max_speed)

##
## Max Speed Along Vector
##
func apply_projected_max_speed(acceleration:Vector3, velocity:Vector3, max_speed:float, max_speed_direction:Vector3)->Vector3:
	var accelerated_velocity = velocity + acceleration
	var accelerated_velocity_in_max_speed_direction = accelerated_velocity.project(max_speed_direction)
	if accelerated_velocity_in_max_speed_direction.length_squared() > max_speed*max_speed:		
		var accel_remainder = acceleration - acceleration.project(max_speed_direction)
		acceleration = accel_remainder + max_speed_direction * max(0, max_speed - velocity.project(max_speed_direction).length())	
	return acceleration
	
