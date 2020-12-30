extends Node

class_name LoadSceneOnPress

export(PackedScene) var scene
onready var parent_button := get_parent() as Button

func _ready():
	parent_button.connect("pressed", self, "on_button_pressed")

func on_button_pressed():
	get_tree().change_scene_to(scene)
