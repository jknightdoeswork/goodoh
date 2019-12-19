extends Node

func sphere_intersects_box(sphere_center:Vector3, sphere_radius:float, box_center:Vector3, box_extents:Vector3) -> bool:
	var squared_distance := squared_distance_from_point_to_box(sphere_center, box_center, box_extents)
	return squared_distance <= sphere_radius * sphere_radius
	
func squared_distance_from_point_to_box(point:Vector3, box_center:Vector3, box_extents:Vector3) -> float:
	var sq := 0.0
	var min_aabb = box_center - box_extents
	var max_aabb = box_center + box_extents
	sq += squared_distance_point_line(point.x, min_aabb.x, max_aabb.x)
	sq += squared_distance_point_line(point.y, min_aabb.y, max_aabb.y)
	sq += squared_distance_point_line(point.z, min_aabb.z, max_aabb.z)
	
	return sq
	
func squared_distance_point_line(pn:float, bmin:float, bmax:float) -> float:
	var out 	:= 0.0
	var v 		:= pn
	if v < bmin:
		var val 	= bmin - v
		out 		+= val * val
	if v > bmax:
		var val 	= v - bmax
		out 		+= val * val
	return out	
	