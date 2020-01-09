extends Spatial
class_name SpawnSpatialListener

export(PackedScene) var scene_to_spawn

func do():
	var p = get_parent()
	var s = scene_to_spawn.instance()
	assert(s is Spatial)
	p.add_child(s)
	s.owner = p
