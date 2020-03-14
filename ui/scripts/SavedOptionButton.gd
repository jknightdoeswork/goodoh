extends OptionButtonOptions

class_name SavedOptionButton

export(String) var setting_key

onready var saved_settings = Engine.get_singleton("SavedSettings")

func _ready() -> void:
	# print ("[SavedOptionButton] ready")
	# Set initial option using setting_key
	var initial_value = saved_settings.set_default_value(setting_key, default_value)
	if setting_key and setting_key.length() > 0:
		initial_value = saved_settings.get_value(setting_key, default_value)
	else:
		print ("[SavedOptionButton] " + name  + " has no setting key.")
	
	select(initial_value)


func on_option_selected(item_index):
	# Store value on option changed
	saved_settings.set_value(setting_key, item_index)

