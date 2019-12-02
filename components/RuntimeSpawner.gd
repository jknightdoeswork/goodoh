extends Node

export(PackedScene) var scene_to_spawn

func _ready():
	if !Engine.editor_hint:
		print ("[RuntimeSpawner] spawning " + str(scene_to_spawn))
		call_deferred("spawn_node")

func spawn_node():
	var p = get_parent()
	var s = scene_to_spawn.instance()
	p.add_child(s)
	s.owner = p
