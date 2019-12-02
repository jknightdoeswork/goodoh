extends OptionButtonOptions

class_name SavedOptionButton

export(String) var setting_key

func _ready() -> void:
	print ("[SavedOptionButton] ready")
	# Set initial option using setting_key
	var initial_value = SavedSettings.set_default_value(setting_key, default_value)
	if setting_key and setting_key.length() > 0:
		initial_value = SavedSettings.get_value(setting_key, default_value)
	else:
		print ("[SavedOptionButton] " + name  + " has no setting key.")

	select(initial_value)


func on_option_selected(item_index):
	# Store value on option changed
	SavedSettings.set_value(setting_key, item_index)
