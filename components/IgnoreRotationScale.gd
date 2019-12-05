extends Node
class_name IgnoreRotationScale

enum UpdateFunction {Process, PhysicsProcess, Ready}
export(UpdateFunction) var update_function = UpdateFunction.Process

func _ready():
	var parent = get_parent()
	assert(parent is Spatial)
	assert(parent.get_parent() is Spatial)
	var prev_transform = parent.transform
	parent.set_as_toplevel(true)
	parent.transform = prev_transform
	
	if update_function == UpdateFunction.Ready:
		do()
		
func do():
	get_parent().translation = get_parent().get_parent().translation
	
func _process(_delta):
	if update_function == UpdateFunction.Process:
		do()

func _physics_process(_delta):
	if update_function == UpdateFunction.PhysicsProcess:
		do()
