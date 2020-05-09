extends Node


export var setting_name := "full_screen"

onready var saved_settings = get_node("/root/SavedSettings")

func _ready():
	assert(saved_settings != null)
	saved_settings.connect("on_value_changed", self, "on_setting_value_changed")

func on_setting_value_changed(setting_key:String, setting_value):
	if setting_key == setting_name:
		assert(setting_value is bool)
		set_full_screen(setting_value)

func set_full_screen(f:bool):
	OS.window_fullscreen = f
