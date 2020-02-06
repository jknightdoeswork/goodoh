tool
extends Spatial
class_name AnchorPoint

export var anchor_point := Vector3.ZERO setget set_anchor_point
export var anchor_point_scale := Vector3(1.0, 1.0, 1.0) setget set_anchor_point_scale

func set_anchor_point_scale(a:Vector3) -> void:
	anchor_point_scale = a
	set_anchor_point(anchor_point)
	
func set_anchor_point(a:Vector3) -> void:
	anchor_point = a
	var child = get_child(0)
	if child != null:
		child.translation = -1.0 * anchor_point * anchor_point_scale