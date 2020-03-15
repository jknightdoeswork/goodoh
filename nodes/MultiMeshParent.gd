tool
extends MultiMeshInstance

class_name MultiMeshParent

var registered_children := []
var needs_update := false

func _enter_tree():
	#print ("Parent enter tree")
	pass

func _ready():
	print ("[BoxMultiMeshRenderer] ready")
	reset_indicies()

func reset_indicies() -> void:
	var i := 0
	for c in registered_children:
		c.instance_id = i
		set_child_transform_with_visibility(c.instance_id, c)
		multimesh.set_instance_color(c.instance_id, c.color)
		i += 1
	
	multimesh.visible_instance_count = registered_children.size()

func deregister_child(c:MultiMeshNode) -> void:
	c.disconnect("color_changed", self, "child_color_changed")
	c.disconnect("transform_changed", self, "child_transform_changed")
	c.disconnect("visibility_changed", self, "child_visibility_changed")
	registered_children.remove(c.instance_id)
	# Todo...?
	reset_indicies()
	#needs_update = true

func register_child(c:MultiMeshNode) -> void:
	#if self.is_inside_tree():
	# Grab instance_id from multimesh count
	c.instance_id = registered_children.size()
	registered_children.append(c)
	
	#multimesh.set_instance_transform(c.instance_id, c.global_transform)
	child_transform_changed(c.instance_id, c)
	child_color_changed(c.instance_id, c.color)
	
	var e = c.connect("color_changed", self, "child_color_changed")
	assert(e == 0)
	e = c.connect("transform_changed", self, "child_transform_changed")
	assert(e == 0)
	e = c.connect("visibility_changed", self, "child_visibility_changed", [c.instance_id, c])
	assert(e == 0)
	#print ("registered " + str(c.instance_id))
	
	multimesh.visible_instance_count = registered_children.size()

func set_child_transform_with_visibility(i:int, child:MultiMeshNode):
	if i >= 0:
		if child.is_visible_in_tree():
			multimesh.set_instance_transform(i, child.global_transform)
		else:
			var t := Transform.IDENTITY
			t = t.scaled(Vector3(0,0,0))
			multimesh.set_instance_transform(i, t)

func child_color_changed(i:int, c:Color):
	#print("child_color_changed")
	if i >= 0:
		multimesh.set_instance_color(i, c)

func child_transform_changed(i:int, c:MultiMeshNode):
	#print ("child transform changed")
	set_child_transform_with_visibility(i, c)

func child_visibility_changed(i:int, child:MultiMeshNode):
	#print ("child visbility changed " + str(child.is_visible_in_tree()))
	set_child_transform_with_visibility(i, child)

func _process(_delta: float) -> void:
	if needs_update:
		#print ("resetting indicies")
		self.reset_indicies()
		needs_update = false

