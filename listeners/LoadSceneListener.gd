extends Node
class_name LoadSceneListener

export(PackedScene) var scene

func do():
	get_tree().change_scene_to(scene)
