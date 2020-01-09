extends Node
class_name SpawnNodeListener

export(PackedScene) var scene_to_spawn

func do():
	var p = get_parent()
	var s = scene_to_spawn.instance()
	p.add_child(s)
	s.owner = p
