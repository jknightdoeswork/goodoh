tool
extends Spatial

class_name MultiMeshNode

signal transform_changed
signal color_changed

export(Color) var color setget set_color
var instance_id := -1

# TODO: Sub class?
# Property?
# CubeRenderer should be generic?
func _enter_tree() -> void:
	#print ("Enter Tree")
	if !is_transform_notification_enabled():
		set_notify_transform(true)
	#BoxRenderer.register_child(self)

func _exit_tree() -> void:
	#print ("Exit Tree")
	#BoxRenderer.deregister_child(self)
	pass

func set_color(c:Color) -> void:
	color = c
	emit_signal("color_changed", instance_id, color)

func _notification(what: int) -> void:
	if what == Spatial.NOTIFICATION_TRANSFORM_CHANGED:
		emit_signal("transform_changed", instance_id, self)
