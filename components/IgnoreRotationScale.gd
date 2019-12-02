extends Node
class_name IgnoreRotationScale

enum UpdateFunction {Process, PhysicsProcess}
export(UpdateFunction) var update_function = UpdateFunction.Process

func _ready():
	var parent = get_parent()
	assert(parent is Spatial)
	assert(parent.get_parent() is Spatial)
	parent.set_as_toplevel(true)
	
func _process(_delta):
	if update_function == UpdateFunction.Process:
		get_parent().translation = get_parent().get_parent().translation

func _physics_process(_delta):
	if update_function == UpdateFunction.PhysicsProcess:
		get_parent().translation = get_parent().get_parent().translation
