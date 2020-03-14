extends Node
class_name LinkPropertyToSetting
export(String) var setting_name
export(String) var property_name

onready var saved_settings = Engine.get_singleton("SavedSettings")

func _ready():
	assert(saved_settings != null)
	assert(self.get_parent() is Node)
	
	if saved_settings.has_value(setting_name):
		var setting_value = saved_settings.get_value(setting_name)
		print ("[LinkPropertyToSetting] set(%s, %s)" % [property_name, setting_value])
		self.get_parent().set(property_name, setting_value)
	else:
		print ("[LinkPropertyToSetting] key %s is unset!" % [setting_name])
