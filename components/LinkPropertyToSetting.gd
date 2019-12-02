extends Node
class_name LinkPropertyToSetting
export(String) var setting_name
export(String) var property_name

func _ready():
	print ("_ready")
	assert(self.get_parent() is Node)
	if SavedSettings.has_value(setting_name):
		var setting_value = SavedSettings.get_value(setting_name)
		print ("[LinkPropertyToSetting] set(%s, %s)" % [property_name, setting_value])
		self.get_parent().set(property_name, setting_value)
	else:
		print ("[LinkPropertyToSetting] key %s is unset!" % [setting_name])
